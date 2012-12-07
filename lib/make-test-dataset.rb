# For each of the speech accent archive files

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