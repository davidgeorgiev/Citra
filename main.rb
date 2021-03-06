require 'fastimage'
require 'rmagick'
require 'fileutils'
require_relative 'color.rb'

if !File.directory?("config") then
	FileUtils::mkdir_p ("config")
end
last_update_is = "running_for_first_time"
last_update_is_copy = String.new
if !File.directory?("last_update") then
	FileUtils::mkdir_p ("last_update")
else
	if File.file?("last_update/the_date_of_the_last_update.citra_config_file_23987") then
		edit_me=File.open('last_update/the_date_of_the_last_update.citra_config_file_23987').read
		edit_me.gsub!(/\r\n?/, "\n")
		counter = 1;
		edit_me.each_line do |line|
			if counter == 1 then
				last_update_is = line.split(/\n/).first
				last_update_is_copy = last_update_is
			end
			counter += 1
		end
	end
end

album_preview_num = 1
addr_to_explr = "address"
min_size = 1;
lim_prop = "no"
line_num=0
max_thumb_pixel_dimensions = 450
max_lightbox_pixel_height = 500
keep_hds = "yes"
only_thumbnails = "no"
proportion_const_by_user = 1.7777777777
edit_me=File.open('edit_me.citra_config_file_23987').read
edit_me.gsub!(/\r\n?/, "\n")
edit_me.each_line do |line|
	if (line.split(":").first == "address to explore") then
		addr_to_explr = line.split(":").last.split(/\n/).first
	end
	if (line.split(":").first == "minimal dimensions") then
		min_size = line.split(":").last.to_i
	end
	if (line.split(":").first == "limitation of proportions yes or no") then
		lim_prop = line.split(":").last.split(/\n/).first
	end
	if (line.split(":").first == "thumbnail max dimensions in pixels") then
		max_thumb_pixel_dimensions = line.split(":").last.to_i
	end
	if (line.split(":").first == "lightbox max height in pixels") then
		max_lightbox_pixel_height = line.split(":").last.to_i
	end
	if (line.split(":").first == "I want to keep hd images in html/hd folder yes/no") then
		keep_hds = line.split(":").last.split(/\n/).first
	end
	if (line.split(":").first == "I want to make only thumbnails and album previews yes/no") then
		only_thumbnails = line.split(":").last.split(/\n/).first
	end
	if (line.split(":").first == "proportion const is") then
		proportion_const_by_user = line.split(":").last.to_f
	end
end

class MyConfig
	def create(album)
		configfile = File.new("config/#{album}.citra_config_file_23987", "w+")
		configfile.close
		configfile = File.new("config/PicExDGAllImgs.citra_config_file_23987", "w+")
		configfile.close
	end
	def add(image_address,name,album,id,width,height,date,thumb_address,date_in_secs,album_preview,image_color)
		configfile = File.new("config/#{album}.citra_config_file_23987", "a+")
		configfile.puts "#{image_address}*sep*#{name}*sep*#{album}*sep*#{id}*sep*#{width}*sep*#{height}*sep*#{date}*sep*#{date_in_secs}*sep*#{thumb_address}*sep*#{album_preview}*sep*#{image_color}"
		configfile.close
		configfile = File.new("config/PicExDGAllImgs.citra_config_file_23987", "a+")
		configfile.puts "#{image_address}*sep*#{name}*sep*#{album}*sep*#{id}*sep*#{width}*sep*#{height}*sep*#{date}*sep*#{date_in_secs}*sep*#{thumb_address}*sep*#{album_preview}*sep*#{image_color}"
		configfile.close
	end
end

class MyDateAndTime
	def date_to_seconds(date)
		in_secs = (date.split(" ")[1].split(":").last.to_i) + (date.split(" ")[1].split(":")[1].to_i*60) + (date.split(" ")[1].split(":")[0].to_i*60*60) + (date.split(" ")[0].split("-").last.to_i*24*60*60) + (date.split(" ")[0].split("-")[1].to_i*30*24*60*60) + (date.split(" ")[0].split("-")[0].to_i*12*30*24*60*60)
		in_secs
	end
end

images = Array.new
id = 0
prop = 0.0
date = " "
dimensions = Array.new
all_addresses = 0
all_albums = 0
address_counter = 0
albums_counter = 0
all_album_names = Array.new
all_album_names_counter = Array.new
part = 0
parts = Array.new
sum_time = 0.0
point_counter = 1
is_there_a_photo = 0
yes_or_no = "yes"
size_of_images = 0.0
size_of_part = 0.0
size_of_part_temp = 0.0
size_of_images_format = ""
sum_of_expected_thumb_pixels = 0.0
sum_of_img_pixels = 0.0
sum_of_all_pixels_of_all_images = 0
all_picture_counter = 0
image_color = Color.new
now_the_time_is = Time.now
now_the_time_is = MyDateAndTime.new.date_to_seconds(now_the_time_is.to_s)

if (last_update_is != "running_for_first_time") then
	last_update_is = MyDateAndTime.new.date_to_seconds(last_update_is)
else
	last_update_is = 0
end

while ((is_there_a_photo == 0) and (yes_or_no == "yes")) do
	Dir.glob("#{addr_to_explr}/**/*.*") do |image_address|
		if (((image_address.split(/\./).last.casecmp("png").zero?) or (image_address.split(/\./).last.casecmp("bmp").zero?) or (image_address.split(/\./).last.casecmp("jpg").zero?) or (image_address.split(/\./).last.casecmp("jpeg").zero?) or (image_address.split(/\./).last.casecmp("gif").zero?) or (image_address.split(/\./).last.casecmp("tif").zero?)) and (image_address.split('/').last.split(".#{image_address.split(/\./).last}").first.length < 255)) and File.file?(image_address) and (!image_address.include? "#{Dir.pwd}") then
			dimensions = FastImage.size(image_address)
			if (dimensions!=nil) then
				width = dimensions[0]
				height = dimensions[1]
			else
				width = 0
				height = 0
			end
			if (MyDateAndTime.new.date_to_seconds(File.mtime(image_address).to_s) > last_update_is) and ((width >= min_size) or (height >= min_size)) then
				dimensions = FastImage.size(image_address)
				if (prop < proportion_const_by_user) then
					all_addresses += 1
				end
				if (lim_prop == "yes") then
					if (width > height) then
						prop = width/height
					else				
						prop = height/width
					end
				end
				if (prop < proportion_const_by_user) then
					size_of_images += File.new(image_address).size
					sum_of_all_pixels_of_all_images += (width*height)
					all_picture_counter += 1
				end
				if point_counter == 30 then
					puts "\e[H\e[2J"
					puts "=============================================="
					puts " Now the directory is analyzing please wait."
					puts "=============================================="
					puts
					puts " #{addr_to_explr}"
					puts "______________________________________________"
				end
				if point_counter == 60 then
					puts "\e[H\e[2J"
					puts "=============================================="
					puts " Now the directory is analyzing please wait.."
					puts "=============================================="
					puts
					puts " #{addr_to_explr}"
					puts "______________________________________________"
				end
				if point_counter == 90 then
					puts "\e[H\e[2J"
					puts "=============================================="
					puts " Now the directory is analyzing please wait..."
					puts "=============================================="
					puts
					puts " #{addr_to_explr}"
					puts "______________________________________________"
					point_counter = 1
				end
				album = image_address.split('/')
				album = album[album.size - 2]
				if !all_album_names.include? album then
							all_album_names << album
				end
				point_counter += 1
				is_there_a_photo = 1
			end
		end
	end
	if (is_there_a_photo == 0) then
		if last_update_is == 0 then
			puts "\e[H\e[2J"
			puts "=============================================="
			puts " No photos in this directory..."
			puts "=============================================="
			puts
			puts " #{addr_to_explr}"
			puts "______________________________________________"
			puts
			puts " Do you want to scan the parent dir - y/n"
			puts "=============================================="
			if $stdin.gets.chomp == "y" then
				addr_to_explr = addr_to_explr.split("/")
				addr_to_explr.delete_at(-1)
				temp = ""
				each_count = 0
				addr_to_explr.each do |element|
					if each_count == 0 then
						temp = temp+"#{element}"
					else
						temp = temp+"/#{element}"
					end
					each_count += 1
				end
				addr_to_explr = temp
			else
				yes_or_no = "n"
			end
		else
			puts "\e[H\e[2J"
			puts "=============================================="
			puts " All photos is already updated"
			puts "=============================================="
			puts
			puts " #{addr_to_explr}"
			puts "______________________________________________"
			puts
			puts " Bye :)"
			puts "=============================================="
			yes_or_no = "n"
			$stdin.gets.chomp
		end
	else
		puts "\e[H\e[2J"
		puts "=============================================="
		puts " Successfully analyzed directory"
		puts "=============================================="
		if last_update_is != 0 then
			puts " last update is on #{last_update_is_copy}"
		else
			puts " now the program is running for first time"
		end
		puts
		puts " #{addr_to_explr}"
		puts
		average_pixels_of_all_images = sum_of_all_pixels_of_all_images/all_picture_counter
		average_width = (Math.sqrt(average_pixels_of_all_images)*(1.333333333)).to_i
		average_height = (Math.sqrt(average_pixels_of_all_images)*(0.75)).to_i
		average_size_of_image = size_of_images/all_picture_counter
		if (size_of_images < 1024) then
			size_of_images_format = "B"
		end
		if (size_of_images > 1024) then
			size_of_images /= 1024
			size_of_images_format = "KB"
		end
		if (size_of_images > 1024) then
			size_of_images /= 1024
			size_of_images_format = "MB"
		end
		if (size_of_images > 1024) then
			size_of_images /= 1024
			size_of_images_format = "GB"
		end
		puts " Found images: #{(size_of_images*100).round/100.0} #{size_of_images_format}"
		if (average_size_of_image < 1024) then
			size_of_images_format = "B"
		end
		if (average_size_of_image > 1024) then
			average_size_of_image /= 1024
			size_of_images_format = "KB"
		end
		if (average_size_of_image > 1024) then
			average_size_of_image /= 1024
			size_of_images_format = "MB"
		end
		if (average_size_of_image > 1024) then
			average_size_of_image /= 1024
			size_of_images_format = "GB"
		end
		puts " Average size of an image: #{(average_size_of_image*100).round/100.0} #{size_of_images_format}"
		puts " Average dimensions of the images: #{average_width}px X #{average_height}px"
		puts "______________________________________________"
		puts
		puts " Do you want to build the directories - y/n"
		puts "=============================================="
		if $stdin.gets.chomp == "y" then
		
			all_albums = all_album_names.size
			previous_dir = " "
			start_timing = Time.now
			
			if (last_update_is != 0) then
				full_config=File.open('config/PicExDGAllImgs.citra_config_file_23987').read
				full_config.gsub!(/\r\n?/, "\n")
				full_config.each_line do |line|
					id += 1
					line_array = line.split("*sep*")
					if !images.include? [line_array[10].to_i,"#{line_array[0]}","#{line_array[1]}","#{line_array[2]}",line_array[3].to_i,line_array[4].to_i,line_array[5].to_i,"#{line_array[6]}","#{line_array[8]}","#{line_array[7]}","#{line_array[9]}"] then
						images << [line_array[10].to_i,"#{line_array[0]}","#{line_array[1]}","#{line_array[2]}",line_array[3].to_i,line_array[4].to_i,line_array[5].to_i,"#{line_array[6]}","#{line_array[8]}","#{line_array[7]}","#{line_array[9]}"]
					end
				end
				
			end
			if File.directory?("config") then
				FileUtils.rm_rf("config")
			end
			FileUtils::mkdir_p ("config")
			
			Dir.glob("#{addr_to_explr}/**/*.*") do |image_address|
				if image_address.split("//").first.length < image_address.length then
					image_address = image_address.gsub! '//', '/'
				end
				if (((image_address.split(/\./).last.casecmp("png").zero?) or (image_address.split(/\./).last.casecmp("bmp").zero?) or (image_address.split(/\./).last.casecmp("jpg").zero?) or (image_address.split(/\./).last.casecmp("jpeg").zero?) or (image_address.split(/\./).last.casecmp("gif").zero?) or (image_address.split(/\./).last.casecmp("tif").zero?)) and (image_address.split('/').last.split(".#{image_address.split(/\./).last}").first.length < 255)) and File.file?(image_address) and (!image_address.include? "#{Dir.pwd}") then
					dimensions = FastImage.size(image_address)
					if (dimensions!=nil) then
						width = dimensions[0]
						height = dimensions[1]
					else
						width = 0
						height = 0
					end
					if (MyDateAndTime.new.date_to_seconds(File.mtime(image_address).to_s) > last_update_is) and ((width >= min_size) or (height >= min_size)) then
						start = Time.now
						changed_address = "#{image_address.split(".#{image_address.split(/\./).last}").first}_#{now_the_time_is}.#{image_address.split(/\./).last}"
						if changed_address.split("%").first.length < changed_address.length then
							changed_address = changed_address.gsub! '%', ' '
						end
						original_photo_address = "#{Dir.pwd}/html/original#{changed_address}"
						hd_photo_address = "#{Dir.pwd}/html/hd#{changed_address}"

						if (lim_prop == "yes") then
							if (width > height) then
								prop = width/height
							else				
								prop = height/width
							end
						end
						if (prop < proportion_const_by_user) then
							avg_clasificated_color = image_color.classificate_the_color(image_color.rgb_to_hsv(image_color.avg_from_image(image_address)))
							FileUtils::mkdir_p "#{Dir.pwd}/html/thumbnails#{image_address.split(image_address.split('/').last).first}"			
							if (only_thumbnails == "no") then
								FileUtils::mkdir_p "#{Dir.pwd}/html/original#{image_address.split(image_address.split('/').last).first}"
							end
							FileUtils::mkdir_p "#{Dir.pwd}/html/album_preview#{image_address.split(image_address.split('/').last).first}"
							FileUtils::mkdir_p "#{Dir.pwd}/html/mini_thumbs#{image_address.split(image_address.split('/').last).first}"
							if (image_address.split(/\./).last != "gif") then
								image = Magick::Image::read(image_address).first
								thumb = image.resize_to_fit!(max_thumb_pixel_dimensions)
								thumb.write ("#{Dir.pwd}/html/thumbnails#{changed_address}")
								thumb_address = "thumbnails#{changed_address}"
							else
								FileUtils.cp(image_address,"#{Dir.pwd}/html/thumbnails#{image_address.split(image_address.split("/").last).first}")
								File.rename("#{Dir.pwd}/html/thumbnails#{image_address}","#{Dir.pwd}/html/thumbnails#{changed_address}")
								thumb_address = "thumbnails#{changed_address}"
							end
							address_counter += 1
							image = Magick::Image::read(image_address).first
							preview_image = image.resize_to_fill(250,250)
							mini_thumb = image.resize_to_fill(72,72)
							preview_image.write ("#{Dir.pwd}/html/album_preview#{changed_address}")
							mini_thumb.write ("#{Dir.pwd}/html/mini_thumbs#{changed_address}")
							preview_address = "album_preview#{changed_address}"
							if (height <= max_lightbox_pixel_height) and (only_thumbnails == "no") then
								FileUtils.cp(image_address,original_photo_address)
								size_of_part = size_of_part+File.new(image_address).size+File.new("#{Dir.pwd}/html/thumbnails#{changed_address}").size+File.new("#{Dir.pwd}/html/album_preview#{changed_address}").size + File.new("#{Dir.pwd}/html/mini_thumbs#{changed_address}").size
							else
								if (only_thumbnails == "no") then
									lightbox_image = image.resize_to_fill(width*max_lightbox_pixel_height/height,max_lightbox_pixel_height)
									lightbox_image.write ("#{Dir.pwd}/html/original#{changed_address}")
								end
								if (keep_hds == "yes") and (only_thumbnails == "no") then
									FileUtils::mkdir_p "#{Dir.pwd}/html/hd#{image_address.split(image_address.split('/').last).first}"
									FileUtils.cp(image_address,hd_photo_address)
									size_of_part = size_of_part+File.new("#{Dir.pwd}/html/hd#{changed_address}").size+File.new("#{Dir.pwd}/html/thumbnails#{changed_address}").size+File.new("#{Dir.pwd}/html/original#{changed_address}").size+File.new("#{Dir.pwd}/html/album_preview#{changed_address}").size + File.new("#{Dir.pwd}/html/mini_thumbs#{changed_address}").size
								else
									if only_thumbnails == "yes" then
										size_of_part = size_of_part+File.new("#{Dir.pwd}/html/thumbnails#{changed_address}").size+File.new("#{Dir.pwd}/html/album_preview#{changed_address}").size + File.new("#{Dir.pwd}/html/mini_thumbs#{changed_address}").size
									end
								end
							
							end
							date = File.mtime(image_address).to_s
							size_of_part_temp = size_of_part
							image_address_temp = image_address
							image_address = "original#{changed_address}"
							date_in_secs =  MyDateAndTime.new.date_to_seconds(date)
							name = image_address.split('/').last.split(/\./).first
							album = image_address.split('/')
							album = album[album.size - 2]
							id = id + 1
							if !images.include? [date_in_secs,image_address,name,album,id,width,height,date,thumb_address,preview_address,avg_clasificated_color] then
								images << [date_in_secs,image_address,name,album,id,width,height,date,thumb_address,preview_address,avg_clasificated_color]
							end
						end
						part = Time.now-start
						parts[address_counter] = part
						for index_of_parts in 1..address_counter do
							sum_time += parts[index_of_parts]
						end
						average_time = sum_time/address_counter
						sum_time = 0.0
						remaining_hours = ((average_time*(all_addresses-address_counter)/60/60).to_i)
						remaining_minutes = ((average_time*(all_addresses-address_counter)/60).to_i) - (remaining_hours*60)
						remaining_seconds = (average_time*(all_addresses-address_counter).to_i) - (remaining_minutes*60)
						elapsed_time = Time.now - start_timing
						elapsed_hours = (elapsed_time/60/60).to_i
						elapsed_minutes = (elapsed_time/60).to_i - elapsed_hours*60
						elapsed_seconds = elapsed_time.to_i - elapsed_minutes*60
						album = image_address.split('/')
						album = album[album.size - 2]
						if !all_album_names_counter.include? album then
									all_album_names_counter << album
						end
						puts "\e[H\e[2J"
						puts "=============================================="
						puts "  Indexing photos and creating thumbnails...  "
						puts "=============================================="
						puts 
						puts "   #{address_counter*100/all_addresses}%"
						puts "   images: #{address_counter}/#{all_addresses}"
						puts "   albums: #{all_album_names_counter.size}/#{all_albums}"
						if (size_of_part_temp < 1024) then
							size_of_part_temp_format = "B"
						end
						if (size_of_part_temp > 1024) then
							size_of_part_temp /= 1024
							size_of_images_format = "KB"
						end
						if (size_of_part_temp > 1024) then
							size_of_part_temp /= 1024
							size_of_images_format = "MB"
						end
						if (size_of_part_temp > 1024) then
							size_of_part_temp /= 1024
							size_of_images_format = "GB"
						end
						puts "   written size: #{(size_of_part_temp*100).round/100.0} #{size_of_images_format}"
						puts "______________________________________________"
						puts 
						puts "   elapsed time   #{elapsed_hours}:#{elapsed_minutes}:#{elapsed_seconds}"
						puts "   remaining time #{remaining_hours}:#{remaining_minutes}:#{remaining_seconds.to_i}"
						puts "______________________________________________"
						puts 
						puts "#{image_address_temp}"
						puts 
						puts "=============================================="
						average_time = 0.0
					end
				end
			end
			print "\n\n"
			for i in 0..id-1 do
				MyConfig.new.create(images[i][3])
			end
			images.sort.reverse.each do |element|
				temp = element[0]
				for i in 1..element.size-1 do
					element[i-1] = element[i]
				end
				element[-1] = temp
				MyConfig.new.add(element[0],element[1],element[2],element[3],element[4],element[5],element[6],element[7],element[8],element[9],element[10])
			end

			
		else
			yes_or_no = "no"
		end
	end
end

the_all_addresses_from_the_file_are = 0
if File.file?("all_addresses.citra_config_file_23987") then
	edit_me=File.open('all_addresses.citra_config_file_23987').read
	edit_me.gsub!(/\r\n?/, "\n")
	counter = 1;
	edit_me.each_line do |line|
		if counter == 1 then
			the_all_addresses_from_the_file_are = line.split(/\n/).first.to_i
		end
		counter += 1
	end
end

if yes_or_no == "yes" then
	all_addresses_file = File.new("all_addresses.citra_config_file_23987", "w+")
	all_addresses_file.puts "#{all_addresses+the_all_addresses_from_the_file_are}"
	all_addresses_file.close
	configfile = File.new("last_update/the_date_of_the_last_update.citra_config_file_23987", "w+")
	configfile.puts Time.now
	configfile.close
end
