"""
Scraping stock data using JSON on bloomberg website 
"""

# Previous method of scraping websites involved scraping the public website which can be very slow. 
# A much faster way would be to use the json response text
import requests 
import re
import json 

def using_json(Abbreviation):
	stockurl = "http://www.bloomberg.com/markets/watchlist/recent-ticker/%s:US" %Abbreviation
	htmlfile = requests.get(stockurl)
	data = htmlfile.json() #json text is a dictionary

	if data[u'last_price'] == 0.0:
		raise ValueError
	return data

while True:
    try:
        abbreviation = str(raw_input("Please give me a stock (eg. GOOG): ")).upper()
        using_json(abbreviation)
    except (ValueError):
        print "Sorry that abbreviation is not valid. Please try again."
        print ''
    else:
    	break

data =  using_json(abbreviation)
print ''
print "==================================================="
print "The price of %s stock is: %s last updated at %s." %(abbreviation, data[u'last_price'], data[u'time_of_last_updt'])
if data[u'pct_chge_1D'] < 0:
	State = "Down"
else:
	State = "Up"
print '%s %s%% from yesterday\'s closing price.' %(State, data[u'pct_chge_1D'])
print ''
