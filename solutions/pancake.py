def pancake_flip(w):

	if "-" not in w:
		return 0

	count = 0
	while "-" in w:
		index = (len(w)-1) - w[::-1].index("-")
		w = flip(w,index)
		count+=1

	return count

def flip(w, index):

	if index == 1:
		return w[index::-1] + w[index+1::]

	flip = list(w[index::-1])
	for j in range(len(flip)):
		if flip[j] == "-":
			flip[j] = "+"
		else:
			flip[j] = "-"

	if index == len(w)-1:
		return "".join(flip)
	else:	
		return "".join(flip) + w[index+1::]

test_number = str(raw_input())


for i in range(int(test_number)):
	test = raw_input()
	print "Case #"+str(i+1) + ": " + str(pancake_flip(test))	
