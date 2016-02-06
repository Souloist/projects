# Project List

A list of practical projects that anyone can solve in any programming language. For now, implementations will be done primarily in python. Every day I plan to commit one solution to an new interesting problem.

Credits
---

This repo was inspired by the following website:

* [Martyr2’s Mega Project List](http://www.dreamincode.net/forums/topic/78802-martyr2s-mega-project-ideas-list/)

List
---

[**Coin Flip Simulation**](https://github.com/Souloist/Projects/blob/master/solutions/Coin_Flip_Simulation.py) - Write a program that simulates flipping a single coin however many times the user decides. The code should record the outcomes and count the number of tails and heads.

[**Quote Finder**](https://github.com/Souloist/Projects/blob/master/solutions/random_quote.py) - Create a script that will parse quotes from a webpage and return a random quote

**PDF Appender** - Create a program that will append one PDF with another

**Happy numbers** - A happy number is defined by the following process. Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers, while those that do not end in 1 are unhappy numbers. Display an example of your output here. Ask for user input for the first N happy numbers.

[**Balanced Parenthesis**](https://github.com/Souloist/Projects/blob/master/solutions/isBalanced.py) - Given a string of parenthesis, decide whether the string is balanced or not

``` 
Balanced:     (()()()())
Unbalanced:   ((((((((())
```
Webcrawling
---

[**Title Retriever**](https://github.com/Souloist/Projects/blob/master/solutions/title_retriever.py) - Create a program that will return the title of a website given the url

**Stock Price Retriever** - Given an stock price abbreviation (eg. GOOG), return the current stock price, the percentage change from the previous day's closing price, and the previous day's closing price. [**[First version]**](https://github.com/Souloist/Projects/blob/master/solutions/get_stock_data.py) [**[Using JSON]**](https://github.com/Souloist/Projects/blob/master/solutions/get_stock_data_json.py)

**1-Day Stock Data** - Given a stock price abbreviation (eg. GOOG), return the entire day's minute stock data and save it to a text file.

Text Manipulation 
---

[**Fizz Buzz**](https://github.com/Souloist/Projects/blob/master/solutions/fizz_buzz.py) - Write a program that prints the numbers from 1 to 100. But for multiples of three print “Fizz” instead of the number and for the multiples of five print “Buzz”. For numbers which are multiples of both three and five print “FizzBuzz”.

[**Reverse a String**](https://github.com/Souloist/Projects/blob/master/solutions/reverse_string.py) - Enter a string and the program will reverse it and print it out.

[**Pig Latin**](https://github.com/Souloist/Projects/blob/master/solutions/pig_latin.py) - Pig Latin is a game of alterations played on the English language game. To create the Pig Latin form of an English word the initial consonant sound is transposed to the end of the word and an ay is affixed (Ex.: "banana" would yield anana-bay). Read Wikipedia for more information on rules.

**Count Vowels** - Enter a string and the program counts the number of vowels in the text. For added complexity have it report a sum of each vowel found.

[**Check if Palindrome**](https://github.com/Souloist/Projects/blob/master/solutions/isPalindrome.java) - Checks if the string entered by the user is a palindrome. That is that it reads the same forwards as backwards like “racecar”

[**Check if Anagram**](https://github.com/Souloist/Projects/blob/master/solutions/isAnagram.py) - Given a pair of strings, return true of those string are anagrams and return false otherwise

**Count Words in a String** - Counts the number of individual words in a string. For added complexity read these strings in from a text file and generate a summary.

**Text Editor** - Notepad style application that can open, edit, and save text documents. Optional: Add syntax highlighting and other features.

**RSS Feed Creator** - Given a link to RSS/Atom Feed, get all posts and display them.

**Quote Tracker (market symbols etc)** - A program which can go out and check the current value of stocks for a list of symbols entered by the user. The user can set how often the stocks are checked. For CLI, show whether the stock has moved up or down. Optional: If GUI, the program can show green up and red down arrows to show which direction the stock value has moved.

**Guestbook / Journal** - A simple application that allows people to add comments or write journal entries. It can allow comments or not and timestamps for all entries. Could also be made into a shout box. Optional: Deploy it on Google App Engine or Heroku or any other PaaS (if possible, of course).

**Vigenere / Vernam / Ceasar Ciphers** - Functions for encrypting and decrypting data messages. Then send them to a friend.

**Regex Query Tool** - A tool that allows the user to enter a text string and then in a separate control enter a regex pattern. It will run the regular expression against the source text and return any matches or flag errors in the regular expression.

Object Orientation
---

**Flappy Bird** - Emulate the popular [flappy bird](http://flappybird.io/) game.

[**Tic Tac Toe**](https://github.com/Souloist/Projects/blob/master/solutions/tic_tac_toe.rb) - Create a tic tac toe game

**Company Manager** - Create an hierarchy of classes - abstract class Employee and subclasses HourlyEmployee, SalariedEmployee, Manager and Executive. Every one's pay is calculated differently, research a bit about it. After you've established an employee hierarchy, create a Company class that allows you to manage the employees. You should be able to hire, fire and raise employees.

**Chess Game** - Create an interactive game of chess using object orientation 
