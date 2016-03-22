def count_vowels(string):
	vowels = ['a', 'e', 'i', 'o', 'u']

	list = {'a':0, 'e':0, 'i':0, 'o':0, 'u':0}

	for letter in string.lower():
		if letter in vowels:
			list[letter]+=1

	print "There are %d a's, %d e's, %d i's, %d o's and %d u's in %s" % (list["a"], list["e"], list["i"], list["o"], list["u"], string)

# test
count_vowels("Hello world")
