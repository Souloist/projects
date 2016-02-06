def isBalanced(string):
	parenthesis = list(string)

	# Python arrays can be used as stacks due to append() and pop()
	stack = []

	for i in parenthesis:

		# Push to stack every opening parenthesis
		if i == "(":
			stack.append(i)
		else:

			# If stack is empty, that means there is an extra closing parenthesis
			if len(stack) == 0:
				return False

			# Pop from stack if you see a closing parenthesis
			stack.pop()

	# If stack is not emtpy at this point, that means theres extra opening parenthesis

	# If stack is empty, that means there were equal number of parenthesis
	return True if len(stack) == 0 else False 

# test
print isBalanced("(((((((())") # False
print isBalanced("()(())(())") # True
