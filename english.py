import re
import os
import urllib
import urllib2
from bs4 import BeautifulSoup
import requests
import json

def getSoup(url):
	html = urllib2.urlopen(url)
	return BeautifulSoup(html)

def getMeaning(word):
	soup = getSoup('http://www.merriam-webster.com/dictionary/'+word)
	meaning=soup.find_all('div',class_='content default')
	print(meaning)
	getAntonymsAndSynomyms(word,soup)
	getSynonymsDiscussion(word,soup)

def getAntonymsAndSynomyms(word,soup):
	return soup.find_all('div',class_='content default')

def getSynonymsDiscussion(word,soup):
	return soup.find_all('div',class_='synonyms-discussion')

def getExamples(word):
	url='http://corpus.vocabulary.com/api/1.0/examples.json?maxResult=24&query='+word
	data = json.load(urllib2.urlopen(url))
	example = []
	for s in data['result']['sentences']:
		example.append(s['sentence'])
	print(example)

def getEtymology(word):
	url = 'http://www.etymonline.com/index.php?term='+word+'&allowed_in_frame=0'
	soup=getSoup(url)
	return soup.find_all('dd',class_='highlight')[0].text

def getImage(word):
	url = 'http://wordpandit.com/2012/'+word+'/'
	soup = getSoup(url)
	content=soup.find_all('img',title=word.title())
	imgUrl = content[0]['src']
	image = urllib.urlretrieve(imgUrl, os.path.basename('/images/'+imgUrl))

def getMnenomonic(word):
	url = 'http://mnemonicdictionary.com/word/'+word        
	soup = getSoup(url)
	return soup.find_all('div',class_='span9')[0].text

def getWordDetails(word,title,desc):
	data = {}
	data['word'] = word
	data['theme-title'] = title
	data['theme-desc'] = desc
	data['etymology'] = getEtymology(word)
	data['mnemonic'] = getMnenomonic(word)
	print(getExamples(word)) 
	#print(data)

def allWordsByGroup(url):
	soup = getSoup(url)
	title=soup.find_all(id='themetitle')[0].string
	desc = soup.find_all(id='themedesc')[0].string
	wordList = soup.find_all('a',class_='positive')
	for word in wordList:
		word = re.sub("\\(.*?\\)","",word.string)
		wordData = getWordDetails(word,title,desc)

def main():
	for i in range(1,2):
		url = 'https://www.greedge.com/grewordlist/words/'+str(i)
		allWordsByGroup(url)

main()			
