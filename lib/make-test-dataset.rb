#!/bin/env ruby
# encoding: UTF-8

require 'FileUtils'
require './lib/split-transcription'
require './lib/convert-transcription'

# For each of the speech accent archive files


# These are the transcriptions which when broken into words aligned 
# => with the paragraph in terms of number of words/utterances 
# => (ie, no alignment fixing required)

length_matching = ["english18", "english23", "english39", "english44", "english46", "english47", "english49", "english50", "english51", "english53", "english55", "english59", "english60", "english62", "english63", "english65", "english67", "english68", "english70", "english71", "english74", "english75", "english76", "english78", "english81", "english82", "english86", "english88", "english90", "english92", "english93", "english95", "english96", "english97", "english98", "english100", "english102", "english103", "english104", "english106", "english107", "english109", "english117", "english118", "english121", "english123", "english124", "english126", "english128", "english131", "english135", "english137", "english138", "english142", "english146", "english147", "english149", "english150", "english151", "english155", "english157", "english158", "english160", "english162", "english163", "english165", "english166", "english167", "english168", "english169", "english170", "english171", "english173", "english177", "english179", "english180", "english181", "english24", "english40", "english56", "english57", "english58", "english80", "english85", "english113", "english134"]
# uk_files = ["english24", "english40", "english56", "english57", "english58", "english80", "english85", "english113", "english134"]

usa_uk_trans_file = File.new('data/test/usa_uk.txt', 'w')
other_trans_file = File.new('data/test/other.txt' ,'w')

rel_path = "data/speech_accent_archive/filename_lists"
Dir.foreach(rel_path) { |filename| 
	# puts "Found file: #{filename} in #{rel_path}"

	if filename.end_with?("English")
		# puts "About to open: #{rel_path}/#{filename}"

		File.open("#{rel_path}/#{filename}") do |infile|
			while( line = infile.gets)
				transcription_filename_base, gender, location, country = line.split('^').map { |e| e.strip }
				transcription = ""
				puts "country: '#{country}'"
				puts "filename: #{transcription_filename_base}"


				if country == "uk" or country == "usa"
					puts "country: '#{country}'"

					break if not length_matching.include?(transcription_filename_base)
				end


				begin

					transcription_file = File.new("data/speech_accent_archive/transcription_txts/#{transcription_filename_base}.rtf", "r")
					# puts "opened: data/speech_accent_archive/transcription_txts/#{transcription_filename_base}.rtf"
					while (line = transcription_file.gets)
						transcription = line[ /\[(.*)\]/ ]
						if transcription
							# puts "Transcription found: #{transcription[0..20]} ... "
							break
						end
					end
					transcription_file.close

					if transcription
						transcription = transcription[1...-1]
						transcribed_word_list = split(transcription)
						transcribed_word_list.map! {|word| convert(word) }

						# puts "Converted transcribed words: #{transcribed_word_list[0..10]} ..."

						# puts "gender: #{gender}"
						# puts "country: '#{country}'"
						# puts "location: #{location}"

						if transcribed_word_list.length != 69
							puts transcribed_word_list.length
							puts "LENGTH DID NOT MATCH: #{transcription_filename_base}. Country: #{country}"
						end

						case country
						when "usa"
							# puts "USA"
							usa_uk_trans_file.puts "usa^#{transcription_filename_base}^#{location}^#{gender}^#{transcribed_word_list}"
						when "uk"
							# puts "UK"
							usa_uk_trans_file.puts "uk^#{transcription_filename_base}^#{transcribed_word_list}"
						else
							# puts "OTHER"
							other_trans_file.puts "#{country}^#{transcription_filename_base}^#{transcribed_word_list}"
						end
					else
						# puts "No transcription found in: #{transcription_filename_base}"
					end

					

				rescue => err
					puts "Exception: #{err}"
					puts err.inspect
					puts err.backtrace
					break
				end

			end # end while reading transcription block
		end # end transcription file block
	end # ends with English
} # end of block for each file in filename_lists

usa_uk_trans_file.close
other_trans_file.close




# outfile = File.new('data/test/usa_uk.txt', 'w')

# usa_files.each do |filename|
# 	begin

# 		# Transcription is on one line between brackets

# 		file = File.new("data/speech_accent_archive/transcription_txts/#{filename}", "r")
# 		while (line = file.gets)

# 			transcription = line[ /\[(.*)\]/ ]

# 			if transcription
# 				outfile.puts "usa^#{filename}^#{transcription[1...-1]}"
# 				break
# 			end
# 		end
# 		file.close

# 	rescue => err
# 		# Maybe file starts with
# 		puts "Exception: #{err}"
# 		err
# 	end
# end

# uk_files.each do |filename|
# 	begin

# 		# Transcription is on one line between brackets


# 		file = File.new("data/speech_accent_archive/transcription_txts/#{filename}", "r")
# 		while (line = file.gets)

# 			transcription = line[ /\[(.*)\]/ ]

# 			if transcription
# 				outfile.puts "uk^#{filename}^#{transcription[1...-1]}"
# 				break
# 			end
# 		end
# 		file.close

# 	rescue => err
# 		# Maybe file starts with
# 		puts "Exception: #{err}"
# 		err
# 	end
# end



# outfile.close


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
