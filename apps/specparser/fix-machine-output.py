#!/usr/bin/env python
# vim: set softtabstop=2 ts=2 sw=2 expandtab: 
import csv,sys,os
import math,re

if __name__ == '__main__':

  try:
    if sys.argv[2] == 'ba':
      interval = 4
      rowStart = 22
  except IndexError:
    interval = 7
    rowStart = 21
  

  """ Open the csv file for reading """
  try: 
    csvfile = open(sys.argv[1],'rb')
  except IOError:
    print 'Unable to open %s file unreadable or not found' % (sys.argv[1])

  try:
    csvreader = csv.reader(csvfile,delimiter=',')
  except:
    print '%s is an invalid or unreadable csv file' % (sys.argv[1])

  print 'Reading %s' % (sys.argv[1])

  paramFilename = sys.argv[1][:-4] + '-params.csv'
  dataFilename  = sys.argv[1][:-4] + '-data.csv'

  try:
    paramFile = open(paramFilename,'wb')
  except IOError:
    print 'Unable to open %s file for writing' % (paramFilename) 

  try:
    dataFile = open(dataFilename,'wb')
  except IOError:
    print 'Unable to open %s file for writing' % (dataFilename)

  if interval == 4:
    dataFields = ['Spec_id','Ba_ppm','La_ppm','Ce_ppm','Ba_Uncertainty','La_Uncertainty','Ce_Uncertainty','Ba_Peak','La_Peak','Ce_Peak','Ba_Background','La_Background','Ce_Background']
  else:
    dataFields = ['Spec_id','Rb_ppm','Sr_ppm','Y_ppm','Zr_ppm','Nb_ppm','Rb_Uncertainty','Sr_Uncertainty','Y_Uncertainty','Zr_Uncertainty','Nb_Uncertainty','Rb_Peak','Sr_Peak','Y_Peak','Zr_Peak','Nb_Peak','Rb_Background','Sr_Background','Y_Background','Zr_Background','Nb_Background']

  paramCsv = csv.writer(paramFile,delimiter=',')
  dataCsv = csv.DictWriter(dataFile, fieldnames=dataFields)
  dataCsv.writeheader()
  rowCount=0
  rowDict={}
  for row in csvreader:
    print row
    print str(rowCount) + ' -- LEN:' + str(len(row))

    """ Make sure there is something in this array """
    if len(row) == 0:
      #print "Less than 6 elements in row, invalid source data file skipping line %s" % (rowCount)
      rowCount = rowCount + 1
      continue
    elif len(row) == 1 and row[0] == 'Results':
      rowStart = rowCount + 3
      rowCount = rowCount + 1
      continue
    elif (rowCount > rowStart) and len(row) == 1:
      """ This is the screwed up non-csv file header row """
      rowDict['Spec_id'] = row[0]
      dataCsv.writerow(rowDict)
      print 'Write row LEN 1'
      rowDict.clear()
      rowCount = rowCount + 1
      continue
    
    if (rowCount < 17):
      paramCsv.writerow(row)
    elif (rowCount > rowStart):
      """ minus 22 every X rows, combined """
      if ((rowCount - rowStart)/float(interval) == math.floor((rowCount - rowStart)/float(interval))) and interval == 7:
        rowDict['Spec_id'] = row[0]
        dataCsv.writerow(rowDict)
        print 'Write row'
        rowDict.clear()
      elif len(row[1]):
        rowDict[row[1]+'_ppm']          = re.sub("[^0-9]",'',row[2])
        rowDict[row[1]+'_Uncertainty']  = row[3]
        rowDict[row[1]+'_Peak']         = row[4]
        rowDict[row[1]+'_Background']   = row[5]
    rowCount = rowCount + 1
print "Proccessing complete output %s and %s :: Proccessed %s lines" % (paramFilename,dataFilename,rowCount)
