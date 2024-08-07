file_name='C:\aitangResearch\MRISimQALaser\try function lib\QA2016.xls';

[qa_cell,txt,raw]=readDailyQAFromExcel(file_name);

qa_cell

class(qa_cell)

size(qa_cell)
qa_cell(1,10)

class(raw)
