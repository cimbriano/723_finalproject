#!/usr/bin/ruby

dict = {}

counter = 1
begin
	file = File.new("data/Arpabet-to-IPA.txt", "r")
	while (line = file.gets)
		arpa, ipa, unicode = line.split

		print "arpa: #{arpa}  "
		print "ipa: #{ipa}  "
		print "unicode: #{unicode}"
		puts 
		dict[arpa] = [ipa, unicode]

	end
	file.close
rescue => err
	puts "Exception: #{err}"
	err
end

puts 
puts "Dictionary"
dict.each do |ele|
	puts "#{ele}: #{dict[ele]}"
end