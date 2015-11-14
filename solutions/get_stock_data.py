"""
Retrieving stock data from yahoo finance
"""

import requests 
from bs4 import BeautifulSoup
import re

def get_stock_data(abbreviation):
	stock_url = "http://finance.yahoo.com/q?s=%s&ql=1" %abbreviation.lower()
	htmlfile = requests.get(stock_url)
	htmltext = BeautifulSoup(htmlfile.text, 'lxml')

	#Extract current stock price
	regex = '<span id="yfs_l84_%s">(.+?)</span>' %abbreviation.lower() # alternatively could use [^.]* instead of %s
	pattern = re.compile(regex)
	current_price = re.findall(pattern, str(htmltext))

	#Extract percentage change of stock since yesterday's closing price
	regex = '<span id="yfs_p43_%s">(.+?)</span>' %abbreviation.lower()
	pattern = re.compile(regex)
	percent_change = re.findall(pattern, str(htmltext))

	#Extract whether the change was positive or negative 
	regex = '<span id="yfs_c63_%s">(.+?)</span>' %abbreviation.lower()
	pattern = re.compile(regex)
	direction_change = re.findall(pattern, str(htmltext))
	integer_change = re.sub(r'\<[^)]*\>', '', str(direction_change)) #Remove everything within <> brackets
	pattern = re.compile("\d+.\d+")
	integer_change = re.findall(pattern, integer_change) #Extract float
	#Determining previous day's closing price
	if len(direction_change) == 0:
		raise IndexError 
	if direction_change[0] == "0.00":
		raise UnboundLocalError
	if "Down" in direction_change[0]:
		State = "Down"
		Previous_CP = float(current_price[0])+float(integer_change[0])
	if "Up" in direction_change[0]:
		State = "Up"
		Previous_CP = float(current_price[0])-float(integer_change[0])

	return current_price[0], State, integer_change[0], percent_change[0], Previous_CP

while True:
    try:
        abbreviation = str(raw_input("Please give me a stock (eg. GOOG): "))
        get_stock_data(abbreviation)
    except (IndexError, UnboundLocalError):
        print "Sorry that abbreviation is not valid. Please try again."
        print ''
    else:
    	break

results = get_stock_data(abbreviation)
print ''
print "==================================================="
print "The price of %s stock is: %s." %(abbreviation.upper(), results[0])
print '%s %s%s from yesterday\'s closing price of %.2f' %(results[1], results[2], results[3], results[4])
print ''
