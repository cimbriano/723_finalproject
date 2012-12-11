#!/usr/bin/ruby

#Speech Accent Archive uses the unicode decimal numbers. 
# "please"
# When Ruby prints "\\u688" -> it outputs \u688
transcribed_word = "p\\u688 \\u616 iz"


# Given a string representing a word.
# => return string of unicode characters

def convert(string)
	word = ""
	unicode = false
	uni_string = ""

	string.each_char do |char|
		
		if char != "\\" and !unicode
			word += convert(char)
		elsif char == "\\"

			unicode = true

		elsif char != " "
			uni_string += char

		elsif unicode and char == " "
			word += convert_char(uni_string)
			uni_string = ""
			unicode = false
		end

	end

	return word

end

def convert_char(char)
	if char.length == 1
		return char
	else
		# Unicode decimal
		puts "char: #{char}"
		unicode_decimal = char[2,char.length]
		puts "decimal: #{unicode_decimal}"
		hex_string = "%.4x" % unicode_decimal
		puts "hex_string: #{hex_string} is string?: #{hex_string.class}"
		return [hex_string.hex].pack("U")
	end
		
end