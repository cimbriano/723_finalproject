#!/usr/bin/ruby



# For each of the speech accent archive files

usa_files = []
uk_files = []

# Collect usa filenames
File.open("data/speech_accent_archive/AmericanEnglish", "r") do |infile|
    while (line = infile.gets)
        usa_files << line.split[0] + '.rtf'
    end
end

# Collect uk filenames
File.open("data/speech_accent_archive/BritishEnglish", "r") do |infile|
    while (line = infile.gets)
        uk_files << line.split[0] + '.rtf'
    end
end


outfile = File.new('data/test/usa_uk.txt', 'w')

usa_files.each do |filename|
	begin

		# Transcription is on one line between brackets


		file = File.new("data/speech_accent_archive/transcription_txts/#{filename}", "r")
		while (line = file.gets)

			transcription = line[ /\[(.*)\]/ ]

			if transcription
				outfile.puts "usa #{transcription}"
				break
			end
		end
		file.close

	rescue => err
		# Maybe file starts with
		puts "Exception: #{err}"
		err
	end
end

uk_files.each do |filename|
	begin

		# Transcription is on one line between brackets


		file = File.new("data/speech_accent_archive/transcription_txts/#{filename}", "r")
		while (line = file.gets)

			transcription = line[ /\[(.*)\]/ ]

			if transcription
				outfile.puts "uk #{transcription}"
				break
			end
		end
		file.close

	rescue => err
		# Maybe file starts with
		puts "Exception: #{err}"
		err
	end
end



outfile.close


# get the pattern at the beginning of the line
	# eg. english32
# and the location (at the end of the line)
	# uk
	# usa
	# other (?)

# Use the pattern to open a file
# => Complication: some are named "English", others are "english"
	# data/sppech_accent_archive/transcription_txts/<pattern>.rtf

# Read out the transcription from the file
# => Not sure how to characterise it yet

# Produce a line of output which includes
	# <location> <transcription>

# Goal: Produce two files
	# 1. One just uk and usa location.
	# 2. Rest of transcriptions (this one is just for fun
	# 		to see how we'd classify (as british or american , even though its neither))
