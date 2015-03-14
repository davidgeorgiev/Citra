require 'fileutils'

address_is = String.new

puts "\e[H\e[2J"
puts "=============================================="
puts "  Parsing URL to your gallery...  "
puts "=============================================="

if File.file?(".git/config") then
	config_git_file = File.open('.git/config').read
	config_git_file.gsub!(/\r\n?/, "\n")
	config_git_file.each_line do |line|
		if line.split("url = https://github.com/").first.length < line.length then
			address_is = line.split("\n").first.split("github.com/").last.split(".git").first
		end
	end
end
address_is = "http://htmlpreview.github.io/?https://github.com/#{address_is}/blob/master/index.html"

puts "  Your URL is: #{address_is}  "
puts "=============================================="
puts
gets.chomp
