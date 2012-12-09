#!/usr/bin/ruby

arpa_to_ipa = {}
ipa_to_arpa = {}



counter = 1
begin
	file = File.new("data/Arpabet-to-IPA.txt", "r")
	while (line = file.gets)
		arpa, ipa, unicode = line.split(',')

		arpa.chomp!
		ipa.chomp!
		unicode.chomp!

		print "arpa: #{arpa}  "
		print "ipa: #{ipa}  "
		print "unicode: #{unicode}"
		puts 
		arpa_to_ipa[arpa] = [ipa, unicode]
		ipa_to_arpa[ipa] = arpa
		

	end
	file.close
rescue => err
	puts "Exception: #{err}"
	err
end

puts 
puts "Dictionary"
arpa_to_ipa.each do |ele|
	puts "#{ele}: #{arpa_to_ipa[ele]}"
end

# Make reverse table (# to character)

