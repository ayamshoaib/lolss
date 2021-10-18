import csv 
import pandas as p

header=['Team', 'Sunday','Monday', 'Tuesday','Wednesday', 'Thursday','Friday']
r1=['Abdulrahman Khaled',None,'normal','ops1','ops2','ops3',None]
r2=['Ahmed Khaled','ops1','ops2','ops3','normal',None,None]
r3=['Mohannad Saeed', 'normal','ops1','ops2','ops3',None,None]
r4=['Aya Mohamed', None, 'ops3','normal','normal','ops2','ops2']
r5=['Ahmed Shams', None,'normal','normal','ops1',None,'ops3']


with open('shifts.csv','w',encoding='UTF8') as f:
	writer = csv.writer(f)
	writer.writerow(header)
	writer.writerow(r1)
	writer.writerow(r2)
	writer.writerow(r3)
	writer.writerow(r4)
	writer.writerow(r5)

x=p.read_csv('shifts.csv')
print(x)

