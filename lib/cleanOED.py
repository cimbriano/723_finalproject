#!/usr/bin/python2.7

#This file is meant to clean up the input data downloaded by the crawler.
#All () sets are changed to 2 instances of the word, with and without the
#parenthesis. Then the primary and secondary stress marks are removed.

import itertools

infile = open('data/speech_accent_archive/OEDResultsUniq.txt').readlines()
outfile = open('data/speech_accent_archive/OEDResultsUniqClean.txt', 'w')
for l in infile:
    if '(' in l:
        parts = []
        parens = []
        while '(' in l:
            oparen = l.find('(')
            parts.append(l[0:oparen])
            l = l[oparen + 1:]
            cparen = l.find(')')
            colon = l.find(':')
            if colon < 0 and cparen < 0:
                parens.append(('', l))
            elif colon > 0 and cparen > 0:
                if colon < cparen:
                    parens.append(('', l[:colon]))
                    l = l[colon:]
                else:
                    parens.append(('', l[:cparen]))
                    l = l[cparen + 1:]
            elif colon > 0:
                parens.append(('', l[:colon]))
                l = l[colon:]
            else:
                parens.append(('', l[:cparen]))
                l = l[cparen + 1:]
        if l:
            parts.append(l)
        for x in itertools.product(*parens):
            outline = ''
            for p1, p2 in zip(parts, x):
                outline += p1 + p2
            outline += parts[-1]
            outline = outline.replace('\xCB\x88', '')
            outline = outline.replace('\xCB\x8C', '')
            outfile.write(outline)
    else:
        l = l.replace('\xCB\x88', '')
        l = l.replace('\xCB\x8C', '')
        outfile.write(l)
outfile.flush()
outfile.close()
