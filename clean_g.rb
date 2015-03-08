require 'fileutils'
Dir.glob("#{Dir.pwd}/**/*.html") do |html_address|
	if File.file?(html_address) then
		FileUtils.rm(html_address)
	end
end
Dir.glob("#{Dir.pwd}/**/*~") do |config_address|
	if File.file?(config_address) then
		FileUtils.rm(config_address)
	end
end
