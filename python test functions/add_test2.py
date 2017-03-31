# Program to send data to QATrack+ testlistcollection
#
# The code uses python's http requests module to encapsulate and send the test results.
# It first logs on with the generic syncuser account, and can then get the csrftoken for subsequent
#	authenticated submissions of test data.
#
# Functions:
#	addtests - adds test results to qatrack+ using http requests
#	updateuser - changes qatrack record of who completed the test based on the domain credentials
#		of the 'user' instead of QATrack's generic 'syncuser' account. Only works if the user 
#		already has an account registered in QATrack+.
#
# Inputs:
#	testcollid - the id of the testlistcollection (i.e. testlist allocated to a given unit)
#	workcompleted - used here to generate testlist start and end datetimes
#	+ values to be sent to QATrack+ test results
#	user - person completing the test - best if this is domain name so it can be mapped 
#		to correct person using the updateuser function

from datetime import date,datetime,timedelta

def addtests(testcollid,work_started,work_completed,result,user):

	#from datetime import date, datetime, timedelta
	import requests
	import time

	root = "http://10.33.72.211/"
	#root = "http://127.0.0.1/"
	# login url
	login_url = root + "accounts/login/"
	# url of UnitTestCollection you want to perform
	
	test_list_url = root + "qa/utc/perform/"+str(testcollid)+"/?day=next"
	print test_list_url
	#print "token before login: " + token
	
	s=requests.Session()

	# We need to get the login page so we can retrieve the csrf token
	res=s.get(login_url)
	token=s.cookies['csrftoken']
	print token
	#print res.url
	login_data = {
		'username':'syncuser',
		'password':'Qx8@%#B3',
		'csrfmiddlewaretoken': token
	}
	# Perform the login
	login_resp = s.post(login_url, data=login_data)
	print "Status code from login: " + str(login_resp.status_code)
	# Get work_started time - say 1 minutes before work_completed
	#work_started=work_completed-timedelta(minutes=1)
	## Convert datetime to required format of DD-MM-YYYY hh:mm from YYYY-MM-DD HH:mm:ss
	work_started = time.strftime("%d-%m-%Y %H:%M",time.strptime(str(work_started),"%Y-%m-%d %H:%M:%S.%f"))
	work_completed = time.strftime("%d-%m-%Y %H:%M",time.strptime(str(work_completed),"%Y-%m-%d %H:%M:%S.%f"))
	print work_started
	print work_completed
	# Encode your form data as strings
	test_data = {
		'csrfmiddlewaretoken': token,
		"work_started": work_started,
		"work_completed": work_completed,
		"status":"2",
		"form-TOTAL_FORMS":"11", 	# change this number to number of form values below
		"form-INITIAL_FORMS":"11",	# change this number to number of form values below
		"form-MAX_NUM_FORMS":"1000",
		"form-0-value":str(result[0]),
		"form-1-value":str(result[1]),
	        "form-2-value":str(result[2]),
	        "form-3-value":str(result[3]),
	        "form-4-value":str(result[4]),
	        "form-5-value":str(result[5]),
	        "form-6-value":str(result[6]),
	        "form-7-value":str(result[7]),
	        "form-8-value":str(result[8]),
	        "form-9-value":str(result[9]),
	        "form-10-string_value":user
	}
	#print test_data
	# Submit test data
	resp = s.post(test_list_url, data=test_data)
	#print "Post data response: " + str(resp)
	#print s.headers
	print resp.status_code # Expect 200 if submitted correctly
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
		if resp:
			print resp
			print "'Performed by' changed to " + user
	else:
		print "No matching user for " + user + ". Leaving 'Performed by' as 'syncuser' for testlistinstance"
		resp = 0
	return resp

if __name__=='__main__':
	
	#import argparse
	
	#parser=argparse.ArgumentParser()
	
	#parser.add_argument('x')
	
	#parser.add_argument('y')
	
	#args=parser.parse_args()
	
	#print args.x,args.y
	
	result=[1,2,3,4,5,6,7,8,9,10]
	
	start_date=datetime.today()
	numseconds=start_date.second
	start_date = start_date-timedelta(seconds=numseconds)
	print start_date
	
	one_day = timedelta(minutes=10)
	
	finished_date=start_date+one_day
	
        print type(finished_date)
	
        addtests(63,start_date,finished_date,result,'AX')
