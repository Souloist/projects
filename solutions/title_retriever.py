'''
Script that will scrape the title of the given website
'''

import urllib
import re

def getstock(title):
    regex = '<title>(.+?)</title>' #find all contents within title braces
    pattern = re.compile(regex) #converts regex into a pattern that can be understood by re module
    htmlfile = urllib.urlopen(title) #takes a string arguement
    htmltext = htmlfile.read()
    titles = re.findall(pattern,htmltext)
    return titles  

while True:
    try:
        title = str(raw_input("Please give me a url: "))
        if not "http" in title:
            title = "http://"+title
        break
    except IOError:
        print "Sorry that url is not valid. Please try another."

print getstock(title)[0]
