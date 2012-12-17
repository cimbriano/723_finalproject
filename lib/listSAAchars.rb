require 'split-transcription'
require 'convert-transcription'

chars = []

begin
	file = File.new("data/test/usa_uk.txt", "r")
	while (line = file.gets)
		parts = line.split('^').map { |e| e.strip }

		if parts[4].nil?
			break
		end

		transcription = parts[4][1...-1]


		transcription.gsub!("[",  "")
		transcription.gsub!("]",  "")
		transcription.gsub!("\"", "")
		transcription.gsub!(" ",  "")
		transcription.gsub!(",",  "")

		transcription.each_char do |c|			
			if !chars.include?(c)
				chars << c
			end
		end		

	end
	file.close
rescue => err
	puts "Exception: #{err}"
	puts err.backtrace
	err
end

outfile = File.new("data/saaChars.txt", "w")

chars.each do |c|
	outfile.print c
end

outfile.close