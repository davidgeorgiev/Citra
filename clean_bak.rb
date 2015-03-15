require 'fileutils'
Dir.glob("#{Dir.pwd}/*~") do |config_address|
	if File.file?(config_address) then
		FileUtils.rm(config_address)
	end
end
