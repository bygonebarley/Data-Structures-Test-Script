#!/usr/bin/env python3
# Author: Jeremy Stevens
# E-mail: jsteve22@nd.edu
# Date: 3/29/2022
# Generate tests for PC07
#
# This test script will generate new passwords and
# corresponding pin files for those passwords. The
# pins will be saved in 'filename'.txt while the 
# passwords would be saved in 'filename'.out
import sys
import random

def main() -> None:

	# use arguments passed at command line to set size of password and name of file
	if len(sys.argv) > 2:
		try: 
			num = int(sys.argv[1])
		except ValueError:
			num = int(sys.stdin.readline().rstrip())
		fname = sys.argv[2]
	elif len(sys.argv) == 2:
		try: 
			num = int(sys.argv[1])
		except ValueError:
			num = int(sys.stdin.readline().rstrip())
		fname = 'test'
	else:
		num = int(sys.stdin.readline().rstrip())
		fname = 'test'

	# return if password can't be made
	if ( num < 3 or num > 10):
		print('Invalide size of password')
		return

	# generate password
	pwrd = gen_password(num)

	print(f'Password = {pwrd}')

	sub_pwrd = least_passwords(pwrd)

	for sub in sub_pwrd:
		print(sub)

	print(' ')

	pins = gen_pins(pwrd,sub_pwrd)
	for p in pins:
		print(p)

	with open(fname+'.txt','w') as fw:
		for p in pins:
			fw.write(f'{p}\n')
	with open(fname+'.out','w') as fp:
		fp.write(f'{pwrd}\n')

	return

def gen_password(size) -> str:
	# given a size of a password, generate a random password
	# of digits with no repeating digits
	avail_nums = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
	pwrd = ""

	if ( size > 10 or size < 0):
		print("Invalid size")
		return ""
	
	for i in range(size):
		num = random.randint(0,len(avail_nums)-1)
		pwrd += avail_nums[num]
		avail_nums.pop(num)
	
	return pwrd

def gen_pins(pwrd, ignore=None) -> list:
	# generate the necessary pins required to 
	# solve the password

	# the program will continually generate valid
	# pins using randint with a limited range.
	# then it will check if the random pin
	# has a 2-seq digit in the password.
	# if so then update the dictionary,
	# increase sub_cnt, and add it to ret
	# if not already there. Continue to add
	# random pins until every 2-seq digit pair
	# is found. 

	# create an empty list to store the pins
	ret = []

	# create a dictionary, set sub_cnt = 0, make s an empty string
	subs = {}
	sub_cnt = 0
	s = ''

	# store every 2 number sequence combination into dictionary
	for i in range(len(pwrd) - 1):
		subs[pwrd[i:i+2]] = False

	# continue to add valid pins until a feasible path exists
	while (sub_cnt < len(pwrd) - 1):
		# create valid pin with forloop
		s = ''
		lo = -1
		for i in range(3):
			lo = random.randint(lo+1,len(pwrd) + len(s) - 3)		
			s += pwrd[lo]
		

		# skip if s is in ignore
		if s not in ignore:
			# check if 2-seq digit is in dictionary
			for i in range(2):
				if s[i:i+2] in subs:
					if subs[s[i:i+2]] == False:
						subs[s[i:i+2]] = True
						sub_cnt += 1
						if s not in ret:
							ret.append(s)
			
	return ret

def least_passwords(pwrd) -> list:
	# take in a password and return a list of the minimum 
	# password pins needed to reconstruct the original password
	ret = []

	if (len(pwrd) < 5):
		return ret

	if (len(pwrd) % 2 == 1):
		for i in range(int(len(pwrd)/2)):
			i *= 2
			ret.append(pwrd[i:i+3])
	else:
		for i in range(int(len(pwrd)/2)):
			i *= 2
			if (len(pwrd[i:i+3]) == 3):
				ret.append(pwrd[i:i+3])
			else:
				ret.append(pwrd[i-1:i+2])

	return ret

if __name__ == '__main__':
	main()
