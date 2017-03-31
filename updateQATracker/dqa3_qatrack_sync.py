# Program to read daily output results from the DQA3 units and import them into a pre-existing
#    testlistinstance and multiple testinstance records in the qatrack database
#
#    Written by: G.Goozee Jan 2014
#
# The following table shows the relationship between the DQA3 field and a required 
#	QATrack+ location (unit or test). DQA3 tables used are: room (r), dqa3_machine (m),
#	 dqa3_template (e), and dqa3_trend (t)
#
#	DQA3 field		QATrack
#	----------		---------
#	r.treename		Linac name maps to Unit (unit_unit:id)
#	e.treename		Energy specific to a test list name
#	t.measured_datetime	testinstance.work_started
#	t.results_dose		Output (cGy/MU)
#	t.results_axsym		Symmetry - axial
#	t.results_trsym		Symmetry - transverse
#	t.results_qaflat	Flatness
#	t.signature		testlistinstance & testinstance.mofified_by_id & created_by_id mapped to auth_user.username
#	t.data_key		Use to link to beam_on_time from sub-query for Tomo

#import python modules
import firebirdsql
from datetime import date, datetime, timedelta
import MySQLdb
import requests
import time


###########
# Functions
###########

def checkmatch(testcollid,testlistid,dt):
# Check to see if dqa result matches existing testlistinstance based on date, time, unit & energy
# convert dt to GMT/UTC time as this is what is stored in database
	str_checkinstance="SELECT id,work_completed FROM qa_testlistinstance WHERE unit_test_collection_id="+ str(testcollid) +" AND test_list_id=" + str(testlistid)+ " AND (work_completed='" + str(dt-timedelta(hours=11)) +"' OR work_completed='" + str(dt-timedelta(hours=10)) +"')"

	print "Checkmatch query: " + str_checkinstance
	print testcollid, testlistid, dt
	found= qat_cur2.execute(str_checkinstance)
	qat_conn.commit()
	if found:
		for row3 in qat_cur2.fetchall():
			val=qat_cur2.fetchone()
			instanceid=row3[0]
			print instanceid, row3[1]
	else:
		print "No instance found"
		instanceid=0
	print "Testlistinstance id =" + str(instanceid)
	return instanceid

def addtests(testcollid,work_completed,output,axsym,trsym,flat,user):
	root = "http://127.0.0.1/"
	# login url
	login_url = root + "accounts/login/"
	# url of UnitTestCollection you want to perform
	
	test_list_url = root + "qa/utc/perform/"+str(testcollid)+"/?day=next"
	print test_list_url
	
	s=requests.Session()

	# We need to get the login page so we can retrieve the csrf token
	res=s.get(login_url)
	token=s.cookies['csrftoken']
	print res.url
	login_data = {
		'username':'syncuser',
		'password':'Qx8@%#B3',
		'csrfmiddlewaretoken': token
	}
	# Perform the login
	login_resp = s.post(login_url, data=login_data)
	# Get work_started time - say 1 minutes before work_completed
	work_started=work_completed-timedelta(minutes=1)
	# Convert datetime to required format of DD-MM-YYYY hh:mm from YYYY-MM-DD HH:mm:ss
	work_started = time.strftime("%d-%m-%Y %H:%M",time.strptime(str(work_started),"%Y-%m-%d %H:%M:%S"))
	work_completed = time.strftime("%d-%m-%Y %H:%M",time.strptime(str(work_completed),"%Y-%m-%d %H:%M:%S"))
	#print work_started
	#print work_completed
	# Encode your form data as strings
	test_data = {
		'csrfmiddlewaretoken': token,
		"work_started":work_started,
		"work_completed":work_completed,
		"status":"2",
		"form-TOTAL_FORMS":"5",
		"form-INITIAL_FORMS":"5",
		"form-MAX_NUM_FORMS":"1000",
		"form-0-value":str(output),
		"form-1-value":str(axsym),
		"form-2-value":str(trsym),
		"form-3-value":str(flat),
		"form-4-string_value":user
	}
	#print test_data
	# Submit test data
	resp = s.post(test_list_url, data=test_data)
	#print "Post data response: " + str(resp)
	#print s.headers
	#print resp.status_code
	return resp

def updateuser(addedinstanceid,user):
# Change the "Performed by" field from the syncuser to the ID of the person who did the measurement
# Relies on that person having an account in QATrack, otherwise leave as syncuser
	str_getid="SELECT id FROM auth_user WHERE username LIKE '" + str(user) + "' LIMIT 1"
	print str_getid
	qat_cur3.execute(str_getid)
	res = qat_cur3.fetchone()
	if res :
		userid=res[0]
		print "userid for " + user + " is " + str(userid)
		str_update="update qa_testlistinstance set created_by_id= " + str(userid) + " WHERE id=" + str(addedinstanceid)

		print str_update
		resp = qat_cur3.execute(str_update)
		qat_conn.commit()
		if resp:
			print resp
			print "'Performed by' changed to " + user
	else:
		print "No matching user for " + user + ". Leaving 'Performed by' as 'syncuser' for testlistinstance"
		resp = 0
	return resp

######################
# Main body of program
######################

unit_id =  [1,2,3,4,5,6]	# For qatracktest
dqa3_linac_id = ["M1","M2","M3","M4","M5","M6"]
#print "In program"

# Set up config information for DQA3 database
DQA3_IP = "10.33.72.205"	# IP address of system holding DQA3 database
DQA3_DB_PATH = "c:\SNC\QADatabase\SNC Databases\sncdata.fdb"	#Location of DQA3 firebird database on DQA3 system
DQA3_USERNAME = "superph"	#Username and password as set with SNC 
DQA3_PASSWORD = "neutrons"

# Set up connection for local qatrack database
qat_conn = MySQLdb.connect(host="localhost", user="qatrack",passwd="qatrackpass",db="qatrackdb")
qat_cur1=qat_conn.cursor()
qat_cur2=qat_conn.cursor()
qat_cur3=qat_conn.cursor()



# Extract the records from DQA3 database for current day
# Flag value of 5 associated with being 'unrecorded' in DQA3, so exclude these

conn=firebirdsql.connect(dsn=DQA3_IP+":"+DQA3_DB_PATH, user=DQA3_USERNAME, password=DQA3_PASSWORD, role="external_role")
c=conn.cursor()
strquery="select r.tree_name, e.tree_name, \
	t.measured_datetime ,t.results_dose, t.results_axsym,t.results_trsym, \
	t.results_qaflat, t.signature, t.set_key, t.data_key \
	from dqa3_trend t \
	join dqa3_template e on (t.set_key = e.set_key) \
	join dqa3_machine m on (e.mach_key = m.mach_key) \
	join room r on (m.room_key = r.room_key) \
	where t.accepted='Y' \
	and t.flags != 5 \
	and extract (day from t.measured_datetime) = extract (day from CURRENT_DATE) \
	and extract (month from t.measured_datetime) = extract (month from CURRENT_DATE) \
	and extract (year from t.measured_datetime) = extract (year from CURRENT_DATE)"


c.execute(strquery)

# Iterate over DQA3 results
# For each row check whether data already in QATack+
# If not, insert the data in qatrack+ database
# Future: check to see if it is Tomo data then perform sub-query to determine beam_on_time
# 
for row in c.fetchall():
	linac=row[0]	# name of linac e.g. M1, M2, etc
	energy=row[1]	# energy
	dt=row[2]	# datetime of measurement
	output=row[3]
	axsym=row[4]
	trsym=row[5]
	flat=row[6]
	user=row[7]
	print 'Linac:{0}, Energy:{1}, Date:{2}, Output:{3:.2f} cGy/MU, Ax_Sym:{4:.1f}%, Tr_Sym:{5:.1f}%,Flatness:{6:.1f}%, User:{7}, Data_key:{8}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[9])
	# strip seconds from dt for checking for existing record in QATrack, which only saves to the minute
	# but which is stored as :00 seconds in database
	#print "Initial dt: " + str(dt)
	numseconds=dt.second
	#print "Numseconds: " + str(numseconds)
	dt=dt-timedelta(seconds=numseconds)
	print "Work_completed dt: " + str(dt)

# Check local qatrack database for entries already imported
# Confirm unittestcollection exists for this machine & energy
	str_findcollection="SELECT t2.name as unit, t3.name, t1.object_id, t1.id  \
		FROM qa_unittestcollection AS t1 \
		JOIN units_unit AS t2 ON t1.unit_id =t2.id \
		JOIN qa_testlist AS t3 ON t3.id=t1.object_id \
		WHERE t2.name LIKE '" + linac + "' \
		AND t3.name LIKE 'Output Checks% " + energy + "'"
#	print str_findcollection
	qat_cur1.execute(str_findcollection)
	for row2 in qat_cur1.fetchall() :
		print "Test collection for unit & energy found"
		testlistid=row2[2]
		testcollid=row2[3]
		#print 'Unit: {0}, Test Name: {1}, testlistid: {2}, testcollid: {3}'.format(row2[0],row2[1],testlistid,testcollid)
		# Check to see if dqa result matches existing testlistinstance based on date, time, unit & energy
		preexistinstanceid=checkmatch(testcollid,testlistid,dt)
		if preexistinstanceid :
			print "Pre-existing matching entry: " + linac + " / " + energy + "(" + str(dt) + "). Instanceid= " + str(preexistinstanceid)
			#updateuser(preexistinstanceid,user)
		else:
			print "Need to add entry"
			addtests(testcollid,dt,output/100,axsym,trsym,flat,user)
			# Get testlistinstanceid
			
			addedinstanceid=checkmatch(testcollid,testlistid,dt)
			print "Just added testlistinstance id: " + str(addedinstanceid)
			updateuser(addedinstanceid,user)
	print




