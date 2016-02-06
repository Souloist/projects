def isBalanced(parenthesis):

	# Python arrays can be used as stacks due to append() and pop()
	stack = []

	for symbol in parenthesis:

		# Push to stack every opening parenthesis
		if symbol in "({[":
			stack.append(symbol)
		else:

			# If stack is empty, that means there is an extra closing parenthesis
			if len(stack) == 0:
				return False

			# Pop from stack if you see a closing parenthesis
			opening = stack.pop()

			# Check to make sure it is the correct closing parenthesis
			if not matches(opening,symbol):
				return False

	# If stack is not emtpy at this point, that means theres extra opening parenthesis

	# If stack is empty, that means there were equal number of parenthesis
	return True if len(stack) == 0 else False 

def matches(opening, closing):
	openers = "{(["
	closers = "})]"

	return openers.index(opening) == closers.index(closing)
# test
print isBalanced("((()]))") # False
print isBalanced("{{([][])}()}") # True
