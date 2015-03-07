require 'fastimage'
require 'rmagick'
require 'fileutils'
require_relative 'color.rb'

pics_on_page_num = 0
albums_num = 0
album_preview_num = 1
addr_to_explr = "address"
min_size = 0;
lim_prop = "no"
line_num=0
max_thumb_pixel_dimensions = 0
max_lightbox_pixel_height = 0
keep_hds = 0
only_thumbnails = "no"
edit_me=File.open('edit_me.txt').read
edit_me.gsub!(/\r\n?/, "\n")
edit_me.each_line do |line|
	if (line.split(":").first == "the number of the albums") then
		albums_num = line.split(":").last.to_i + 1
	end
	if (line.split(":").first == "the number of the pics in gallery on one page") then
		pics_on_page_num = line.split(":").last.to_i + 1
	end
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
end

class MyConfig
	def create(album)
		configfile = File.new("config/#{album}.txt", "w+")
		configfile.close
		configfile = File.new("config/PicExDGAllImgs.txt", "w+")
		configfile.close
	end
	def add(image_address,name,album,id,width,height,date,thumb_address,date_in_secs,album_preview,image_color)
		configfile = File.new("config/#{album}.txt", "a+")
		configfile.puts "#{image_address}*sep*#{name}*sep*#{album}*sep*#{id}*sep*#{width}*sep*#{height}*sep*#{date}*sep*#{date_in_secs}*sep*#{thumb_address}*sep*#{album_preview}*sep*#{image_color}"
		configfile.close
		configfile = File.new("config/PicExDGAllImgs.txt", "a+")
		configfile.puts "#{image_address}*sep*#{name}*sep*#{album}*sep*#{id}*sep*#{width}*sep*#{height}*sep*#{date}*sep*#{date_in_secs}*sep*#{thumb_address}*sep*#{album_preview}*sep*#{image_color}"
		configfile.close
	end
end

class Html
	def create_index_page
		pagefile = File.new("index1.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"html/css/main.css\">\n\t</head>\n\t<body>"
		pagefile.close
	end
	def create_page(page_name,name_for_link)
		pagefile = File.new("html/#{page_name}.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">\n\t\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"lightbox/lightbox.css\" media=\"screen\" /><script type=\"text/javascript\" src=\"lightbox/lightbox.js\"></script></head>\n\t<body><div id=\"buttons\"><a id = \"nextprevious\" href = \"#{name_for_link}_clasificated_by_color_PicExDG_disp_list.html\">Clasificated by color</a></div>"
		pagefile.close
	end
	def create_page_color_clasificated(page_name,base_page)
		pagefile = File.new("html/#{page_name}.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">\n\t\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"lightbox/lightbox.css\" media=\"screen\" /><script type=\"text/javascript\" src=\"lightbox/lightbox.js\"></script></head>\n\t<body><div id=\"buttons\"><a id = \"previous_b\" href = \"#{base_page}.html\">Prev</a>"
		pagefile.close
	end
	def create_color_list(page_name)
		pagefile = File.new("html/#{page_name}_clasificated_by_color_PicExDG_disp_list.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">\n\t</head>\n\t<body>"
		pagefile.close
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
while ((is_there_a_photo == 0) and (yes_or_no == "yes")) do
	Dir.glob("#{addr_to_explr}/**/*.*") do |image_address|
		if (((image_address.split(/\./).last == "png") or (image_address.split(/\./).last == "bmp") or (image_address.split(/\./).last == "jpg") or (image_address.split(/\./).last == "jpeg") or (image_address.split(/\./).last == "gif") or (image_address.split(/\./).last == "tif")) and (image_address.split('/').last.split(/\./).first.length < 255)) and File.file?(image_address) and (!image_address.include? "#{Dir.pwd}") then
			dimensions = FastImage.size(image_address)
			if (dimensions!=nil) then
				width = dimensions[0]
				height = dimensions[1]
			else
				width = 0
				height = 0
			end
			if (((width >= min_size) or (height >= min_size))) and (prop < 1.7777777777) then
				all_addresses += 1
			end
			if ((width >= min_size) or (height >= min_size)) then
				if (lim_prop == "yes") then
					if (width > height) then
						prop = width/height
					else				
						prop = height/width
					end
				end
			end
			if (prop < 1.7777777777) then
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
	if (is_there_a_photo == 0) then
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
		if gets.chomp == "y" then
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
		puts " Successfully analyzed directory"
		puts "=============================================="
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
		if gets.chomp == "y" then
		
			all_albums = all_album_names.size
			previous_dir = " "
			start_timing = Time.now
			td_counter = -1;
			Dir.glob("#{addr_to_explr}/**/*.*") do |image_address|
				if (((image_address.split(/\./).last == "png") or (image_address.split(/\./).last == "bmp") or (image_address.split(/\./).last == "jpg") or (image_address.split(/\./).last == "jpeg") or (image_address.split(/\./).last == "gif") or (image_address.split(/\./).last == "tif")) and (image_address.split('/').last.split(/\./).first.length < 255)) and File.file?(image_address) and (!image_address.include? "#{Dir.pwd}") then
					start = Time.now
					original_photo_address = "#{Dir.pwd}/html/original#{image_address}"
					hd_photo_address = "#{Dir.pwd}/html/hd#{image_address}"
					dimensions = FastImage.size(image_address)
					if (dimensions!=nil) then
						width = dimensions[0]
						height = dimensions[1]
					else
						width = 0
						height = 0
					end

					if ((width >= min_size) or (height >= min_size)) then
						if (lim_prop == "yes") then
							if (width > height) then
								prop = width/height
							else				
								prop = height/width
							end
						end
						if (prop < 1.7777777777) then
							avg_clasificated_color = image_color.classificate_the_color(image_color.rgb_to_hsv(image_color.avg_from_image(image_address)))
							FileUtils::mkdir_p "#{Dir.pwd}/html/thumbnails#{image_address.split(image_address.split('/').last).first}"			
							if (only_thumbnails == "no") then
								FileUtils::mkdir_p "#{Dir.pwd}/html/original#{image_address.split(image_address.split('/').last).first}"
							end
							FileUtils::mkdir_p "#{Dir.pwd}/html/album_preview#{image_address.split(image_address.split('/').last).first}"
							if (image_address.split(/\./).last != "gif") then
								image = Magick::Image::read(image_address).first
								thumb = image.resize_to_fit!(max_thumb_pixel_dimensions)
								thumb.write ("#{Dir.pwd}/html/thumbnails#{image_address.split(image_address.split('/').last).first}#{image_address.split("/").last}")
								thumb_address = "thumbnails#{image_address.split(image_address.split('/').last).first}#{image_address.split("/").last}"
							else
								FileUtils.cp(image_address,"#{Dir.pwd}/html/thumbnails#{image_address.split(image_address.split("/").last).first}")
								thumb_address = "thumbnails#{image_address}"
							end
							address_counter += 1
							image = Magick::Image::read(image_address).first
							preview_image = image.resize_to_fill(250,250)
							preview_image.write ("#{Dir.pwd}/html/album_preview#{image_address.split(image_address.split('/').last).first}#{image_address.split("/").last}")
							preview_address = "album_preview#{image_address}"
							if (height <= max_lightbox_pixel_height) and (only_thumbnails == "no") then
								FileUtils.cp(image_address,original_photo_address)
								size_of_part = size_of_part+File.new(image_address).size+File.new("#{Dir.pwd}/html/thumbnails#{image_address}").size
							else
								if (only_thumbnails == "no") then
									lightbox_image = image.resize_to_fill(width*max_lightbox_pixel_height/height,max_lightbox_pixel_height)
									lightbox_image.write ("#{Dir.pwd}/html/original#{image_address.split(image_address.split('/').last).first}#{image_address.split("/").last}")
								end
								if (keep_hds == "yes") and (only_thumbnails == "no") then
									FileUtils::mkdir_p "#{Dir.pwd}/html/hd#{image_address.split(image_address.split('/').last).first}"
									FileUtils.cp(image_address,hd_photo_address)
									size_of_part = size_of_part+File.new("#{Dir.pwd}/html/hd#{image_address}").size+File.new("#{Dir.pwd}/html/thumbnails#{image_address}").size+File.new("#{Dir.pwd}/html/original#{image_address}").size+File.new("#{Dir.pwd}/html/album_preview#{image_address}").size
								else
									size_of_part = size_of_part+File.new(image_address).size+File.new("#{Dir.pwd}/html/thumbnails#{image_address}").size+File.new("#{Dir.pwd}/html/album_preview#{image_address}").size
								end
								
							end
							date = File.mtime(image_address).to_s
							size_of_part_temp = size_of_part
							image_address_temp = image_address
							image_address = "original#{image_address}"
							date_in_secs = (date.split(" ")[1].split(":").last.to_i) + (date.split(" ")[1].split(":")[1].to_i*60) + (date.split(" ")[1].split(":")[0].to_i*60*60) + (date.split(" ")[0].split("-").last.to_i*24*60*60) + (date.split(" ")[0].split("-")[1].to_i*30*24*60*60) + (date.split(" ")[0].split("-")[0].to_i*12*30*24*60*60)
							name = image_address.split('/').last.split(/\./).first
							album = image_address.split('/')
							album = album[album.size - 2]
							id = id + 1
							if !images.include? [date_in_secs,image_address,name,album,id,width,height,date,thumb_address,preview_address,avg_clasificated_color] then
								images << [date_in_secs,image_address,name,album,id,width,height,date,thumb_address,preview_address,avg_clasificated_color]
							end
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

			Html.new.create_index_page

			Dir.glob("#{Dir.pwd}/config/*.txt") do |my_config_file|
				only_name = my_config_file.split("/").last.split(".txt").first
				Html.new.create_page(only_name,only_name)
				Html.new.create_color_list(only_name)
			end

			album_counter = 0
			page_counter = 2
			page_counter2 = 2
			photo_counter = 0
			page_name = "index1.html"
			page_name2 = "example.html"
			Dir.glob("#{Dir.pwd}/config/*.txt") do |my_config_file|
				colors_info = Hash.new(0)
				page_counter2 = 2
				i = 0
				k = 0
				if (album_counter > 0) then
					pagefile = File.new(page_name, "a+")
					pagefile.puts "</p></a></div>"
					pagefile.puts "</td>"
					if td_counter == 3 then
						pagefile.puts "</tr><tr>"
					end
					pagefile.close
				else
					pagefile = File.new(page_name, "a+")
					pagefile.puts "<div id=\"buttons\"><a id = \"nextprevious\" href = \"html/PicExDGAllImgs.html\">All photos in gallery [#{all_addresses} photos]</a></div>"
					pagefile.puts "<table><tr>"
					pagefile.close
				end
				album_counter = album_counter + 1
				if td_counter <= 4 then
					td_counter += 1
				else
					td_counter = 2
				end
				text=File.open(my_config_file).read
				text.gsub!(/\r\n?/, "\n")
				text.each_line do |line|
					k = k + 1
				end
				text.each_line do |line|
					colors_info[line.split("*sep*")[9]] += 1
				end
				temp_my_config_file = my_config_file
				my_config_file = my_config_file.split("/").last.split(".txt").first
				color_list_page_name = "html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list.html"
				color_list_page = File.new(color_list_page_name, "a+")
				color_list_page.puts "<table><tr>"
				td_color_list_page_counter = 0
				colors_info.each do |color,number|
					color_list_page.puts "<td><div class = \"index_album\"><a href = \"#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color}.html\" ><p id = \"title\">#{color}: [#{number} photos]</p><p><img src=\"colors/#{color}.jpg\" alt=\"#{color}\" id=\"index_photo\"/></p></a></div></td>"
					Html.new.create_page_color_clasificated("#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color}","#{my_config_file}_clasificated_by_color_PicExDG_disp_list")
					td_color_list_page_counter += 1
					if td_color_list_page_counter == 4 then
						color_list_page.puts "</tr><tr>"
						td_color_list_page_counter = 0
					end
				end
				if td_color_list_page_counter == 4 then
					color_list_page.puts "</tr>"
				end
				color_list_page.puts "</table><div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}.html\">Prev</a></div></body></html>"
				color_list_page.close
				page_name2 = "#{my_config_file}.html"
				pagefile2 = File.new("html/#{page_name2}", "a+")
				random = Random.rand(2)
				if (random == 1) then
					pagefile2.puts "\t\t<div class = \"album2\">"
				else
					pagefile2.puts "\t\t<div class = \"album\">"
				end
				page_counter_with_that_color = Hash.new(1)
				photo_counter_with_that_color = Hash.new(1)
				text.each_line do |line|
					photo_counter = photo_counter + 1
					if page_counter_with_that_color[line.split("*sep*")[9]] == 1 then
						page_with_images_in_current_color = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{line.split("*sep*")[9]}.html", "a+")
					else
							page_with_images_in_current_color = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{line.split("*sep*")[9]}#{page_counter_with_that_color[line.split("*sep*")[9]]}.html", "a+")
					end
					if photo_counter_with_that_color[line.split("*sep*")[9]] == 1 then
						random = Random.rand(5)
						if (random == 1) then
							page_with_images_in_current_color.puts "\t\t<div class = \"album2\">"
						else
							page_with_images_in_current_color.puts "\t\t<div class = \"album\">"
						end	
					end
					if (photo_counter_with_that_color[line.split("*sep*")[9]] <= pics_on_page_num-1) then
						random = Random.rand(2)
						if (random == 1) then
							page_with_images_in_current_color.puts "\t\t\t#{line.split("*sep*")[6].split(" ").first}<a id=\"images_and_date\" href=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]}\" rel=\"lightbox\"><img src=\"#{line.split("*sep*")[8]}\" alt=\"#{line.split("*sep*")[1]}\" id=\"gallery_photo\" title = \"#{line.split("*sep*")[1][0..20]}..#{line.split("*sep*")[0][-4..-1]} [#{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px]\"/></a>"
						else
							page_with_images_in_current_color.puts "\t\t\t<a id=\"images_and_date\" href=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]}\" rel=\"lightbox\"><img src=\"#{line.split("*sep*")[8]}\" alt=\"#{line.split("*sep*")[1]}\" id=\"gallery_photo\" title = \"#{line.split("*sep*")[1][0..20]}..#{line.split("*sep*")[0][-4..-1]} [#{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px]\"/></a>#{line.split("*sep*")[6].split(" ").first}"
						end
						if photo_counter_with_that_color[line.split("*sep*")[9]] == pics_on_page_num-1 then
							page_with_images_in_current_color.puts "\t\t</div>"
							if page_counter_with_that_color[line.split("*sep*")[9]]*photo_counter_with_that_color[line.split("*sep*")[9]] < colors_info[line.split("*sep*")[9]] then
								page_with_images_in_current_color.puts "<a id = \"next_b\" href = \"#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{line.split("*sep*")[9]}#{page_counter_with_that_color[line.split("*sep*")[9]]+1}.html\">Next</a></div>"
								page_with_images_in_current_color.puts "</body></html>"
								if page_counter_with_that_color[line.split("*sep*")[9]] == 1 then
									Html.new.create_page_color_clasificated("#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{line.split("*sep*")[9]}#{page_counter_with_that_color[line.split("*sep*")[9]]+1}","#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{line.split("*sep*")[9]}")
								else
									Html.new.create_page_color_clasificated("#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{line.split("*sep*")[9]}#{page_counter_with_that_color[line.split("*sep*")[9]]+1}","#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{line.split("*sep*")[9]}#{page_counter_with_that_color[line.split("*sep*")[9]]}")
								end
								page_counter_with_that_color[line.split("*sep*")[9]] += 1
							end
							photo_counter_with_that_color[line.split("*sep*")[9]] = 0
						end
						photo_counter_with_that_color[line.split("*sep*")[9]] += 1
					end
					page_with_images_in_current_color.close
					if (photo_counter == pics_on_page_num) then #the number of the pics in gallery + 1
						pagefile2.puts "\t\t</div>"
						if ((page_counter2 != 3) and (page_counter2 != 2)) then
							pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}#{page_counter2-2}.html\">Prev</a>"
						else
							if (page_counter2 == 2) then
								if (page_counter != 3)
									pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"../index#{page_counter - 1}.html\">Prev</a>"
								end
							else
								pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}.html\">Prev</a>"
							end
						end
						pagefile2.puts "<a id = \"next_b\" href = \"#{my_config_file}#{page_counter2}.html\">Next</a></div>"
						pagefile2.puts "</body></html>"
						pagefile2.close
						Html.new.create_page("#{my_config_file}#{page_counter2}","#{my_config_file}")
						page_name2 = "#{my_config_file}#{page_counter2}.html"
						pagefile2 = File.new("html/#{page_name2}", "a+")
						pagefile2.puts "\t\t<div class = \"album\">"
						photo_counter = 1
						page_counter2 = page_counter2 + 1
					end
					random = Random.rand(2)
					if (random == 1) then
						pagefile2.puts "\t\t\t#{line.split("*sep*")[6].split(" ").first}<a id=\"images_and_date\" href=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]}\" rel=\"lightbox\"><img src=\"#{line.split("*sep*")[8]}\" alt=\"#{line.split("*sep*")[1]}\" id=\"gallery_photo\" title = \"#{line.split("*sep*")[1][0..20]}..#{line.split("*sep*")[0][-4..-1]} [#{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px]\"/></a>"
					else
						pagefile2.puts "\t\t\t<a id=\"images_and_date\" href=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]}\" rel=\"lightbox\"><img src=\"#{line.split("*sep*")[8]}\" alt=\"#{line.split("*sep*")[1]}\" id=\"gallery_photo\" title = \"#{line.split("*sep*")[1][0..20]}..#{line.split("*sep*")[0][-4..-1]} [#{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px]\"/></a>#{line.split("*sep*")[6].split(" ").first}"
					end
					random = Random.rand(5)
					if (random == 2) then
						pagefile2.puts "<br></br>"
					end
		
					i = i + 1
					if (album_counter == albums_num) then #the number of the albums + 1
						pagefile = File.new(page_name, "a+")
						previous = "index#{page_counter - 2}.html"
						if (page_name != "index1.html") then
							pagefile.puts "</tr></table>"
							td_counter = 0
							pagefile.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{previous}\">Prev</a>"
						else
							pagefile.puts "</tr></table>"
							td_counter = 0
							pagefile.puts "<div id=\"buttons\">"
						end
						page_name = "index#{page_counter}.html"
						pagefile.puts "<a id = \"next_b\" href = \"#{page_name}\">Next</a></div>"
						pagefile.close
						pagefile = File.new(page_name, "w+")
						pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"html/css/main.css\">\n\t</head>\n\t<body>"
						album_counter = 1
						page_counter = page_counter + 1
						pagefile.puts "<div id=\"buttons\"><a id = \"nextprevious\" href = \"html/PicExDGAllImgs.html\">All photos in gallery</a></div>"
						pagefile.puts "<table><tr>"
						pagefile.close
					end
					if (i == 1) then
						pagefile = File.new(page_name, "a+")
						pagefile.puts "<td>"
						pagefile.puts "<div class = \"index_album\"><a href = \"html/#{line.split("*sep*")[2]}.html\" ><p id = \"title\">#{line.split("*sep*")[2]}: [#{k} photos]</p><p>"
						pagefile.close
					end
					if (i <= album_preview_num) then #the number of the pics on album's example
						pagefile = File.new(page_name, "a+")
						pixels_in_each = Array.new
						date_inc_in_each = Array.new
						config_file_to_chek=File.open(temp_my_config_file).read
						config_file_to_chek.gsub!(/\r\n?/, "\n")
						line1_counter = 0
						config_file_to_chek.each_line do |line1|
							line1_counter += 1
							pixels_in_each << [(line1.split("*sep*")[4].to_i)*(line1.split("*sep*")[5].to_i),line1.split("*sep*")[7],line1.split("*sep*")[8],line1.split("*sep*")[1]]
						end
						config_file_to_chek=File.open(temp_my_config_file).read
						config_file_to_chek.gsub!(/\r\n?/, "\n")
						line1_counter = 0
						config_file_to_chek.each_line do |line1|
							line1_counter += 1
							date_inc_in_each << [(line1.split("*sep*")[10].to_i),line1.split("*sep*")[7],line1.split("*sep*")[8],line1.split("*sep*")[1]]
						end
						if line1_counter == 1 then
							if pixels_in_each[0][1].length > 0 then
								pagefile.puts "<img src=\"html/#{pixels_in_each[0][1]}\" alt=\"#{pixels_in_each[0][3]}\" id=\"index_photo\"/>"
							else
								pagefile.puts "<img src=\"html/#{pixels_in_each[0][2]}\" alt=\"#{pixels_in_each[0][3]}\" id=\"index_photo\"/>"
							end
						end
						temp_index_date_inc = 1
						date_inc_in_each_first_element = Array.new
						temp_index = 1
						date_inc_in_each.reverse.sort do |current_image_and_date_inc|
							if temp_index_date_inc == 1 then
								date_inc_in_each_first_element = current_image_and_date_inc
							end
							temp_index_date_inc += 1
						end
						pixels_in_each.reverse.sort do |current_image_and_pixels|
							if (temp_index <= album_preview_num) then
									if pixels_in_each[0][1].length > 0 then
										pagefile.puts "<img alt=\"#{pixels_in_each[0][3]}\" id=\"index_photo\" src=\"html/#{pixels_in_each[0][1]}\" onmouseout=\"this.src=\'html/#{pixels_in_each[0][1]}\'\""
									else
										pagefile.puts "<img alt=\"#{pixels_in_each[0][3]}\" id=\"index_photo\" src=\"html/#{pixels_in_each[0][2]}\" onmouseout=\"this.src=\'html/#{pixels_in_each[0][2]}\'\""
									end
									if date_inc_in_each_first_element[1].length > 0 then
										pagefile.puts " onmouseover=\"this.src=\'html/#{date_inc_in_each_first_element[1]}\'\"/>"
									else
										pagefile.puts " onmouseover=\"this.src=\'html/#{date_inc_in_each_first_element[2]}\'\"/>"
									end
									pagefile.puts ""
							end
							temp_index+=1
						end
						pagefile.close
					end
				end
				pagefile2.puts "\t\t</div>"
				if (page_counter2 - 2 > 1) then
					pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}#{page_counter2 - 2}.html\">Prev</a></div>"
				else
					if page_counter2 == 3 then
						pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}.html\">Prev</a></div>"
					end
					if page_counter2 == 2 then
							pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"../index#{page_counter-1}.html\">Prev</a></div>"
					end
				end
				pagefile2.puts "</body></html>"
				pagefile2.close
			end

			pagefile = File.new(page_name, "a+")
			pagefile.puts "</p></a></div>"
			pagefile.puts "</td>"
			pagefile.puts "</tr></table>"
			td_counter = 0
			pagefile.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"index1.html\">Prev</a></div>"
			pagefile.close
		end
	end
end
