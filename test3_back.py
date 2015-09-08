# test3.py
import subprocess
import sys # args

f = open("file_info2.txt", 'r')
f2 = open("result3.po", 'r')
f3 = open("temp3.txt", 'w')
f4 = open("temp4.txt", 'w')

# make the empty dictionary
file_type = dict() # file_name to file_type
file_num = dict() # file_type to file_number

lst = [[0 for col in range(16)] for row in range(15)]
lst2 = [[0 for col in range(16)] for row in range(3)] # Block to rwbs
action = {"Q": 0, "M": 1, "F": 2, "G": 3, "S": 4, "R": 5, "D": 6, "C": 7, "P": 8, "U": 9, "UI": 10, "I": 11, "X": 12, "B": 13, "A": 14}
rwbs = {"R": 0, "W": 1, "N": 2}
# File Type Define
size = 0
while 1:
	line = f.readline()
	line = line.replace("\n", "")
	if not line : break
	data = line.split(" ")
	for i in data:
		if not i == data[0]:
			file_type[i] = data[0]
	file_num[data[0]] = size
	size += 1
file_num['ETC_FILE'] = size
print(file_type)

# General IO => File type
while 1:
	line = f2.readline()
	line = line.replace("\n", "")
	if not line : break
	data = line.split("\t")
	leng = len(data[8])
	fname = [0 for _ in range(300)]
	temp  = data[8]
	
	# RWBS
        if data[2].find("R") >= 0:
                tmp = "R"
        elif data[2].find("W") >= 0:
                tmp = "W"
        elif data[2] == "N":
                tmp = "N"

	cur_type = 'ETC_FILE'
	for i in file_type.keys():
		index = data[8].find(i)
		print(data[8]+','+i+','+str(leng)+','+str(data[8].find(i))+','+str(len(i)))
		if index >= 0 and (leng - index) == len(i) and (data[8][index-1] == '.' or data[8][index-1] == '-'):
			cur_type = file_type[i]	
	print(data[8]+' : '+cur_type)
	#f3.write(data[8]+' : '+cur_type+'\n')
	if not cur_type == 'NONE_FILE':
		#lst[action[data[1]]][file_num[cur_type]] += 1
		lst2[rwbs[tmp]][file_num[cur_type]] += 1

# Write the Parsing Data - Number
# Columns
order = 0
for i in range(0, size+1):
        f3.write('\t'+file_num.keys()[file_num.values().index(order)])
        order += 1
f3.write('\n')
# Rows + Elements
order = 0
for i in lst2:
        f3.write(rwbs.keys()[rwbs.values().index(order)])
        for index in range(0, size+1):
                f3.write('\t'+str(i[index]))
        f3.write('\n')
        order += 1
print(file_num)

# Write the Parsing Data - Percentage(%)
# Columns
order = 0
for i in range(0, size+1):
        f4.write('\t'+file_num.keys()[file_num.values().index(order)])
        order += 1
f4.write('\n')
# Rows + Elements
order = 0
for i in lst2:
	rowSums = sum(i, 0.0)
        f4.write(rwbs.keys()[rwbs.values().index(order)]+":"+str(int(rowSums)))
        for index in range(0, size+1):
		if not rowSums == 0:
                	f4.write('\t'+str((i[index])*100/rowSums))
		else:
			f4.write('\t'+str(i[index]))
        f4.write('\n')
        order += 1
"""
order = 0
for i in lst:
        f4.write(action.keys()[action.values().index(order)])
        for index in range(0, size+1):
                f4.write('\t'+str(i[index]))
        f4.write('\n')
        order += 1
print(file_num)
"""

exe = 'Rscript rscript3.r'
# Output file option
if sys.argv.count('-o') == 1:
        ind = sys.argv.index('-o') + 1
        out = sys.argv[ind].split('.')
        exe = exe +' -o '+ sys.argv[ind] +' ' + out[1] # out[1] : file_extension


# File Close
f.close()
f2.close()
f3.close()
f4.close()

print(exe)
# Execute the R script.
subprocess.call(exe, shell=True)
