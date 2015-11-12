import random

def cointoss(number):
	heads = 0
	tails = 0
	Outcomes = [0,1] #0 for tails, 1 for heads
	for i in xrange(number):
		flip = random.choice(Outcomes)
		if flip == 0:
			tails+=1
		else:
			heads+=1
	return "You got "+ str(heads) +" heads and " + str(tails)+ " tails" 

while True:
	try:
		number = int(raw_input("How many times do you want to roll? "))
		break
 	except (NameError, SyntaxError, ValueError):
 		print "Opps. That doesn't work. Please enter a number!"

print cointoss(number)