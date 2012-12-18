#!/bin/env ruby
# encoding: UTF-8

#Speech Accent Archive uses the unicode decimal numbers. 
# "please"
# When Ruby prints "\\u688" -> it outputs \u688
transcribed_word = "p\\u688 \\u616 iz"


# Given a string representing a word.
# => return string of unicode characters

def convert(string)
	# Adding space to handle words that end in a unicode character
	string += " "

	word = ""
	unicode = false
	uni_string = ""

	# puts "Starting each char..."
	string.each_char do |char|
		
		# puts "char: #{char}"

		if char != "\\" and !unicode
			# puts "Adding #{char} to word"
			word += convert_char(char)

		elsif char == "\\"
			# puts "Starting unicode string"
			uni_string = "\\"
			unicode = true

		elsif char != " " and unicode
			# puts "Putting #{char} in unicode string: #{uni_string}"
			uni_string += char

		elsif unicode and char == " "
			# puts "Found end of unicode string: #{uni_string}"
			word += convert_char(uni_string)
			uni_string = ""
			unicode = false
		else
			puts "Not sure what to do with #{char}"
		end
	end

	# Strip to remove extra spaces
	return word.strip

end

def convert_char(char)
	if char.length == 1
		return char
	else
		# Unicode decimal
		# puts "char: #{char}"
		unicode_decimal = char[2,char.length]
		# puts "decimal: #{unicode_decimal}"
		hex_string = "%.4x" % unicode_decimal
		# puts "hex_string: #{hex_string} is string?: #{hex_string.class}"
		converted_char = [hex_string.hex].pack("U")

		# puts "cleaning up: #{converted_char}  result: '#{cleanup(converted_char)}'"

		return cleanup(converted_char)
	end
		
end

def cleanup(pre)

	# diacritics = ["ˠ", "̆", "̥", "̊", "̬", "ʰ", "̹", "̜", "̟", "̠", "̈", "̽", "̩", "̯", "˞", "̤", "̰", "̼", "ɣ", "ʕ", "̴", "̝", "̞", "̘", "̙", "̪", "̺", "̻", "̃", "̚", "˺"]
	diacritics = ["ˠ", "̆", "̥", "̊", "̬", "ʰ", "̹", "̜", "̟", "̠", "̈", "̽", "̩", "̯", "˞", "̤", "̰", "̼", "ɣ", "ʕ", "̴", "̝", "̞", "̘", "̙", "̪", "̺", "̻", "̚", "˺", "ˀ", "ʷ", "ʲ"]

	character_mapping = {	"ɝ" => "ɜ", 
							"ɚ" => "ə",
							"ʧ"	=> "tʃ",
							"ʈ" => "t",
							"β" => "b",
							"ɐ" => "æ",
							"ɵ" => "d",
							"ɹ" => "r",
							"ɾ" => "d",
							"ʔ"	=> "t",
							"ɸ" => "ɸ",
							"ɻ"	=> "r",
							"ɞ"	=> "ʌ",
							"ɘ"	=> "ɪ",
							"ɨ"	=> "iː",
							"ʉ"	=> "uː"

						}

	word = ""

	pre.each_char do |c|

		if !diacritics.include?(c)
			word += (character_mapping[c] || c)
		end
	end

	return word
end


