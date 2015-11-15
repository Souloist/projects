def pig_latin(input_string):
	new_string = []
	for i in input_string.split():
		if i[0] not in "aeiou":
			i = i[1:]+i[0]
		i +="ay"
		new_string.append(i)
	return ' '.join(new_string)

def main():
	user_input = str(raw_input("Please give me a phrase: "))
	print pig_latin(user_input)

if __name__ == '__main__':
	main()
