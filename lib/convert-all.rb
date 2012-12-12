#!/bin/env ruby
# encoding: UTF-8

require './lib/convert-transcription'

trans = ["p\\uc0\\u688 l\\u805 \\u601 iz ","k\\u596 l ","st\\u601 \\u603 l\\u652  ","\\u230 sk ","h\\u605  ","t\\u688 \\u117 \\u774  ","b\\u633 \\u601 \\u774 \\u618 \\u771 \\u331  ","\\u240 i\\u720 z ","\\u952 \\u618 \\u331 z ","w\\u618 \\u952  ","h\\u605  ","f\\u633 \\u652 m ","\\u240 \\u601  ","sto\\u601 \\u633  ","s\\u618 ks ","spu\\u771 \\u797 \\u720 nz ","\\u652 v\\u805  ","f\\u633 \\u603 \\u643  ","sno\\u650 \\u774  ","p\\u601 i\\u720 z ","fa\\u720 v ","\\u952 \\u618 k ","sl\\u230 bz ","\\u601 \\u118 \\u774  ","blu\\u797  ","\\u679 i\\u720 z ","\\u603 \\u774 n ","m\\u603 bi ","\\u601  ","sn\\u230 k ","f\\u111 \\u774 \\u633  ","h\\u605  ","b\\u633 \\u652 \\u240 \\u602  ","b\\u593 \\u720 b ","wi ","also ","ni\\u720 d ","\\u601  ","sm\\u593 \\u720 l ","p\\u688 l\\u805 \\u230 st\\u618 k ","sne\\u618 k ","\\u603 n ","\\u601  ","b\\u618 \\u609 \\u762  ","t\\u688 \\u596 \\u618  ","f\\u633 \\u596 \\u609  ","f\\u601  ","\\u240 \\u601  ","k\\u688 i\\u601 dz\\u805  ","\\u643 i ","k\\u688 \\u601 n ","s\\u720 ku\\u797 p ","\\u240 i\\u720 z ","\\u952 \\u601 \\u618 \\u331 z\\u805  ","\\u618 nt\\u688 u ","\\u952 \\u633 i\\u720  ","\\u633 ed ","b\\u230 \\u720 \\u609 z\\u805  ","\\u603 n ","wi ","w\\u618 l ","\\u609 o\\u650  ","mi\\u720 t ","h\\u605  ","w\\u618 \\u771 nzdi ","\\u230 t ","\\u240 \\u601  ","t\\u633 e\\u618 \\u771 n ","ste\\u618 \\u643 \\u601 n",]

trans.each do |word|
	puts convert(word)
end