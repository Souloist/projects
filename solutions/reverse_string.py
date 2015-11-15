def reverse_string(input_string):
	new_string = []
	for i in range(len(input_string)-1, -1, -1): # or you could use reversed(range(len(input_string)))
		new_string.append(input_string[i])
	new_string = ''.join(new_string)
	return new_string

def main():
	user_input = str(raw_input("Please give me a string: "))
	print reverse_string(user_input)

if __name__ == '__main__':
	main()
