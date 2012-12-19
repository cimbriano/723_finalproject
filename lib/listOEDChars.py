#This file is meant to list all of the characters that appear in the OED data
#after it has been cleaned.

#!/usr/bin/python2.7
output = []
for line in open('data/oedclean.txt').readlines():
    words = line.split(':')
    if len(words) > 1:
        for l in words[1:]:
            l = l.strip()
            i = 0
            while i < len(l):
                char = ord(l[i])
                if char >> 1 == 0x7E:
                    count = 5
                elif char >> 2 == 0x3E:
                    count = 4
                elif char >> 3 == 0x1E:
                    count = 3
                elif char >> 4 == 0xE:
                    count = 2
                elif char >> 5 == 0x6:
                    count = 1
                else:
                    count = 0
                add = 1
                for j in range(count):
                    if not ord(l[i + j + 1]) >> 6 == 2:
                        add += 1
                        count = j + 1
                        break
                    else:
                        add += 1
                output.append(l[i:i + count + 1])
                i += add
outfile = open('data/oedChars.txt', 'w')
outfile.write(''.join(set(output)))
