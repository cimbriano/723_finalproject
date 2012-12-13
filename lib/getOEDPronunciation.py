#!/usr/bin/python2.7
import itertools
import Queue
import random
import re
import threading
import urllib

THREAD_COUNT = 3
q = Queue.Queue()
phon_regex = re.compile('^.*<span\s*class="phonetics">(.*)</span>.*$')

def get_page(line):
    q.put((line, urllib.urlopen('http://www.oed.com/view/Entry/%s' % line.pop()).readlines()))

def find_pronunciation(page):
    it = iter(page[1])
    brit,us = '',''
    try:
        while '<strong>Pronunciation:</strong>' not in next(it):
            pass
    except StopIteration:
        return (page[0], brit, us)
    for i in range(2):
        state = False
        for line in it:
            if 'Brit.' in line:
                state = True
                break
            if 'U.S.' in line:
                break
            match = phon_regex.match(line)
            if match:
                return (page[0], match.group(1), us)
        if state:
            for line in it:
                match = phon_regex.match(line)
                if match:
                    brit = match.group(1)
                    break
        else:
            for line in it:
                match = phon_regex.match(line)
                if match:
                    us = match.group(1)
                    break
    return (page[0], brit, us)

if __name__ == "__main__":
    with open('../data/oed-wordlist.txt', 'r') as dict_file:
        dic = [line.strip().split(':') for line in dict_file.readlines()]
    length = len(dic)
    thread_len = length/THREAD_COUNT
    dic = random.sample(dic, length)
    threads = []
    for i in range(THREAD_COUNT):
        if i < THREAD_COUNT-1:
            threads.append(threading.Thread(target=map, args=(get_page, dic[i*thread_len:(i+1)*thread_len])))
        else:
            threads.append(threading.Thread(target=map, args=(get_page, dic[i*thread_len:])))
        threads[i].start()
    count = 0
    for i in range(len(dic)):
        word = find_pronunciation(q.get())
        print word[0][0] + ':' + str(word[1]) + ':' + str(word[2])

