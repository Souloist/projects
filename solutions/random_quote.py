from bs4 import BeautifulSoup
import requests 
import re  
from random import randint 

page = requests.get('http://www.politico.com/magazine/story/2015/08/the-absolute-trumpest-121328')
soup = BeautifulSoup(page.text, 'lxml')
list_of_quotes = re.findall(r'<p>(.*?)</p>',str(soup)) #only return the contents with paragraph tags
list_of_quotes = list_of_quotes[:len(list_of_quotes)-1] #remove extraneous paragraph tag
remove_list = ['<i>', '</i>', '<em>', '</em>'] # array of words we want to edit out of soup
remove = '|'.join(remove_list)

for num in range(len(list_of_quotes)): 
	regex = re.compile(r'('+remove+')', flags=re.IGNORECASE) #remove items on list
	list_of_quotes[num] = regex.sub("", list_of_quotes[num])
	list_of_quotes[num] = re.sub(r'\([^)]*\)', '', list_of_quotes[num]) #remove paranthesis 
	if num < 9:
		list_of_quotes[num] = list_of_quotes[num][4::]
	else:
		list_of_quotes[num] = list_of_quotes[num][5::]
	list_of_quotes[num] +="- Trump"

# generate random quote
def randomquote():
	return list_of_quotes[randint(0, len(list_of_quotes))]