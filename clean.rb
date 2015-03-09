require 'fileutils'
if File.directory?("html/album_preview") then
	FileUtils.rm_rf("html/album_preview")
end
if File.directory?("html/hd") then
	FileUtils.rm_rf("html/hd")
end
if File.directory?("html/original") then
	FileUtils.rm_rf("html/original")
end
if File.directory?("html/thumbnails") then
	FileUtils.rm_rf("html/thumbnails")
end
if File.directory?("html/mini_thumbs") then
	FileUtils.rm_rf("html/mini_thumbs")
end
Dir.glob("#{Dir.pwd}/**/*.html") do |html_address|
	if File.file?(html_address) then
		FileUtils.rm(html_address)
	end
end
Dir.glob("#{Dir.pwd}/config/*.citra_config_file_23987") do |config_address|
	if File.file?(config_address) then
		FileUtils.rm(config_address)
	end
end
if File.file?("all_addresses.citra_config_file_23987") then
		FileUtils.rm("all_addresses.citra_config_file_23987")
end
Dir.glob("#{Dir.pwd}/*~") do |config_address|
	if File.file?(config_address) then
		FileUtils.rm(config_address)
	end
end
