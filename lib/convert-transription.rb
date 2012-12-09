#!/usr/bin/ruby

#Speech Accent Archive uses the unicode decimal numbers. 
# "please"
# When Ruby prints "\\u688" -> it outputs \u688
transcribed_word = "p\\u688 \\u616 iz"


# Given a string representing a word.
# => return string of unicode characters

def convert(string)

end

def convert_char(char)
	if char.length == 1
		return char
	else
		# Unicode decimal

		hex = "%.4" % char[3, char.length]
		return [hex].pack("U")
	end
		
end