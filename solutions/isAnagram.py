# This is run in O(n) time

def isAnagram(string1, string2):

	# Anagrams must be same length
	if len(string1) != len(string2):
		return False

	count1 = [0]*26
	count2 = [0]*26

	for i in range(len(string1)):
		count1[ord(string1[i].lower()) - ord('a')]+=1
		count2[ord(string2[i].lower()) - ord('a')]+=1


	if count1==count2: #since anagrams have the same letters
		return True
	else:
		return False

# check
print isAnagram("HeArt", "Earth")
