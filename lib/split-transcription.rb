#!/bin/env ruby
# encoding: UTF-8

raw = "p\\uc0\\u688 l\\u805 i\\u720 z kol st\\u603 l\\u652  \\u230 \\u797 sk \\u604 \\u774  t\\u117 \\u774  b\\u633 \\u618 \\u771 \\u331  \\u240 i\\u720 z\\u810  t\\u810 \\u618 \\u771 \\u331 z w\\u618 \\u240  \\u604 \\u720  f\\u633 \\u601 \\u771 m n\\u810 \\u601  sto\\u720  s\\u618 ks spu\\u771 \\u720 nz \\u601 v f\\u633 \\u603 \\u643  \\u643 n\\u603 \\u650  p\\u601 iz f\\u594 \\u618 v \\u952 \\u618 k sl\\u230 \\u798 bz \\u601 v blu\\u798  \\u679 \\u601 iz n\\u809  m\\u593 \\u618 bi \\u601  sn\\u230 k f\\u602  \\u604  b\\u633 \\u652 \\u240 \\u601  b\\u593 \\u720 b\\u805  wi \\u596 lso\\u650  ne\\u797 d \\u601  sm\\u596 l p\\u688 l\\u805 \\u230 st\\u618 k sne\\u618 k \\u601 \\u771 n \\u601  b\\u618 \\u609  t\\u596 \\u618  f\\u633 \\u596 \\u774 \\u609  f\\u601  \\u240 \\u601  k\\u618 d\\u805 s \\u643 i k\\u601 \\u771 n sk\\u601 up \\u240 i\\u720 z \\u952 \\u618 \\u771 \\u331 z \\u618 \\u774 nt\\u117 \\u774  \\u952 \\u633 i\\u720  \\u633 \\u603 d\\u762  b\\u230 \\u797 \\u609 \\u805 s \\u601 \\u771 n wi w\\u618 l \\u609 o\\u799 \\u650  m\\u601 it \\u604  w\\u603 \\u771 nzdi\\u720  \\u601 t \\u240 \\u601  t\\u633 e\\u618 \\u771 n ste\\u771 \\u618 \\u643 \\u601 \\u771 n"

# text = "please call stella ask her to bring these things with her from the store six spoons of fresh snow peas five thick slabs of blue cheese and maybe a snack for her brother bob we also need a small plastic snake and a big toy frog for the kids she can scoop these things into three red bags and we will go meet her wednesday at the train station"
# text = text.split
# # Space after ascii letter -> Word spearator.
# # Space after \u### helps find the end of the \u###
# # Two spaces after \u### -> word spearator

# # unicode_pattern = /\\u\w{0,4}/

# us_match = []
# uk_match = []


# # Collect usa filenames
# File.open("data/test/usa_uk.txt", "r") do |infile|

# 	counter = 0
# 	while (line = infile.gets)
# 		words = []


# 		location, filename, transcription = line.split('^')
# 		# puts "Location: #{location}"
# 		# puts "Transcription: #{transcription}"
# 		words = transcription.scan(/(([a-z]|\\u\w{0,4}|\\u\w{0,4} )*([a-z]|\\u\w{0,4} )( |\Z))/)
# 		# puts "Words Array"
# 		words.map! { |e| e[0] }
# 		puts words
# 		puts "words.length - text.length: #{words.length - text.length}"
# 		if words.length - text.length == 0
# 			if location == "usa"
# 				us_match << filename
# 			elsif location == "uk"
# 				uk_match << filename
# 			else
# 				puts "Matched but wrong location: #{location}"
# 			end
# 		end				

# 		break
# 	end

# end

# puts words

# puts "Number of US matching: #{us_match.length}"
# puts "US Matching: #{us_match}. "

# puts "Number of UK matching: #{uk_match.length}"
# puts "UK Matching: #{uk_match}"

def split(trans)
	words = trans.scan(/(([a-z]|\\u\w{0,4}|\\u\w{0,4} )*([a-z]|\\u\w{0,4} )( |\Z))/)
		# puts "Words Array"
	words.map! { |e| e[0] }
end

puts split(raw)