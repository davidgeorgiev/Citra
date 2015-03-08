require 'fileutils'
Dir.glob("#{Dir.pwd}/config/*.txt") do |config_address|
	if File.file?(config_address) then
		File.rename(config_address,"#{config_address.split(".txt").first}.citra_config_file_23987")
	end
end
