require 'open-uri'
require 'nokogiri'
require 'net/http'

# url = "http://www.oed.com/srupage?operation=searchRetrieve&query=cql.serverChoice+=+test&maximumRecords=100&startRecord=1"
url = "http://www.oed.com/view/Entry/199677"
doc = Nokogiri::XML(open(url), &:noblanks)

# p doc

doc.css('span.phonetics').each do |thing|
	puts thing
end