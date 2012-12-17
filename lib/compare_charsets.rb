oed = []
saa = []

files = [ ["data/oedChars.txt", oed], ["data/saaChars.txt", saa] ]



files.each do |filename, list|
	
	File.open(filename, "r") { |file|  
		while(line = file.gets)

			line.each_char do |c|
				list << c
			end

		end
	}		
end

intersection = oed & saa
only_oed = oed - intersection
only_saa = saa - intersection

puts "Only OED: #{only_oed}"
puts "Only SAA: #{only_saa}"