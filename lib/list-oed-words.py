#!/usr/bin/python2.7

#This file will crawl the OED webpage to generate a list of all words in the
#OED online along with the unique identifier used to find their page on the
#OED online.

import httplib
import re
con = httplib.HTTPConnection('www.oed.com')
con.request('GET', "/browsedictionary?browseType=sortAlpha&page=1&pageSize=10&scope=ENTRY&sort=entry&type=dictionarybrowse")
page = con.getresponse().read()
link_regex = re.compile('^\s*<a\s*href="/view/Entry/(\d*)\?.*$')
word_regex = re.compile('^.*<span\s*class="hw">\s*(.*?)\s*</span>.*$')
result = int(re.search('<span\s*id=\s*"resultsTotal">\s*(\d*)\s*</span>', page).group(1))
if result%100:
    pages = result/100+1
else:
    pages = result/100
for i in range(1, pages+1):
    con.request('GET', "/browsedictionary?browseType=sortAlpha&page=%d&pageSize=100&scope=ENTRY&sort=entry&type=dictionarybrowse" % i)
    page = con.getresponse().read()
    word = None
    for l in page.split('\n'):
        if word:
            match = link_regex.match(l)
            if match:
                print word + ' ' + match.group(1)
                word = None
        else:
            match = word_regex.match(l)
            if match:
                word = match.group(1)
