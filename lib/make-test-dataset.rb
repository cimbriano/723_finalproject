#!/usr/bin/ruby



# For each of the speech accent archive files


# These are the transcriptions which when broken into words aligned 
# => with the paragraph in terms of number of words/utterances 
# => (ie, no alignment fixing required)

usa_files = ["english18.rtf", "english23.rtf", "english39.rtf", "english44.rtf", "english46.rtf", "english47.rtf", "english49.rtf", "english50.rtf", "english51.rtf", "english53.rtf", "english55.rtf", "english59.rtf", "english60.rtf", "english62.rtf", "english63.rtf", "english65.rtf", "english67.rtf", "english68.rtf", "english70.rtf", "english71.rtf", "english74.rtf", "english75.rtf", "english76.rtf", "english78.rtf", "english81.rtf", "english82.rtf", "english86.rtf", "english88.rtf", "english90.rtf", "english92.rtf", "english93.rtf", "english95.rtf", "english96.rtf", "english97.rtf", "english98.rtf", "english100.rtf", "english102.rtf", "english103.rtf", "english104.rtf", "english106.rtf", "english107.rtf", "english109.rtf", "english117.rtf", "english118.rtf", "english121.rtf", "english123.rtf", "english124.rtf", "english126.rtf", "english128.rtf", "english131.rtf", "english135.rtf", "english137.rtf", "english138.rtf", "english142.rtf", "english146.rtf", "english147.rtf", "english149.rtf", "english150.rtf", "english151.rtf", "english155.rtf", "english157.rtf", "english158.rtf", "english160.rtf", "english162.rtf", "english163.rtf", "english165.rtf", "english166.rtf", "english167.rtf", "english168.rtf", "english169.rtf", "english170.rtf", "english171.rtf", "english173.rtf", "english177.rtf", "english179.rtf", "english180.rtf", "english181.rtf"]
uk_files = ["english24.rtf", "english40.rtf", "english56.rtf", "english57.rtf", "english58.rtf", "english80.rtf", "english85.rtf", "english113.rtf", "english134.rtf"]

# # Collect usa filenames
# File.open("data/speech_accent_archive/AmericanEnglish", "r") do |infile|
#     while (line = infile.gets)
#         usa_files << line.split[0] + '.rtf'
#     end
# end

# # Collect uk filenames
# File.open("data/speech_accent_archive/BritishEnglish", "r") do |infile|
#     while (line = infile.gets)
#         uk_files << line.split[0] + '.rtf'
#     end
# end


outfile = File.new('data/test/usa_uk.txt', 'w')

usa_files.each do |filename|
	begin

		# Transcription is on one line between brackets


		file = File.new("data/speech_accent_archive/transcription_txts/#{filename}", "r")
		while (line = file.gets)

			transcription = line[ /\[(.*)\]/ ]

			if transcription
				outfile.puts "usa^#{filename}^#{transcription[1...-1]}"
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
				outfile.puts "uk^#{filename}^#{transcription[1...-1]}"
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
