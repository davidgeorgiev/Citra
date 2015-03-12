all_addresses = 0
all_addresses_file=File.open('all_addresses.citra_config_file_23987').read
all_addresses_file.gsub!(/\r\n?/, "\n")
all_addresses_file.each_line do |line|
		all_addresses = line.split("\n").first.to_i
end
td_counter = -1;
pics_on_page_num = 0
albums_num = 0
album_preview_num = 1
max_lightbox_pixel_height = 0
only_photos_with_suitable_dimenssions = "no"
keep_hds = "yes"
line_num=0
edit_me=File.open('edit_me.citra_config_file_23987').read

put_me_to_the_bottom = "<span id=\"bazinga\"></span><a data-scroll href=\"#bazinga2\">Go to the top</a>
<script>
smoothScroll.init({
    speed:"
put_me_to_the_bottom2 = ", // Integer. How fast to complete the scroll in milliseconds
    easing: 'Linear', // Easing pattern to use
    updateURL: true, // Boolean. Whether or not to update the URL with the anchor hash on scroll
    offset: 0, // Integer. How far to offset the scrolling anchor location in pixels
    callbackBefore: function ( toggle, anchor ) {}, // Function to run before scrolling
    callbackAfter: function ( toggle, anchor ) {} // Function to run after scrolling
});
</script>"

edit_me.gsub!(/\r\n?/, "\n")
edit_me.each_line do |line|
	if (line.split(":").first == "the number of the albums") then
		albums_num = line.split(":").last.to_i + 1
	end
	if (line.split(":").first == "the number of the pics in gallery on one page") then
		pics_on_page_num = line.split(":").last.to_i + 1
	end
	if (line.split(":").first == "lightbox max height in pixels") then
		max_lightbox_pixel_height = line.split(":").last.to_i
	end
	if (line.split(":").first == "only photos whith suitable dimenssions in slideshows yes/no") then
		only_photos_with_suitable_dimenssions = line.split(":").last.split(/\n/).first
	end
	if (line.split(":").first == "I want to keep hd images in html/hd folder yes/no") then
		keep_hds = line.split(":").last.split(/\n/).first
	end
end
class Html
	def create_index_page
		pagefile = File.new("index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"html/css/main.css\">\n\t<script src=\"html/themes/5/smooth-scroll.js\"></script></head>\n\t<body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"html/logo.png\"/></a></div>"
		pagefile.close
	end
	def create_page(page_name,name_for_link)
		pagefile = File.new("html/#{page_name}.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">\n\t\n\t\t<script src=\"themes/5/smooth-scroll.js\"></script><link rel=\"stylesheet\" type=\"text/css\" href=\"lightbox/lightbox.css\" media=\"screen\" /><script type=\"text/javascript\" src=\"lightbox/lightbox.js\"></script></head>\n\t<body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"logo.png\"/></a></div><div id=\"buttons\"><a id = \"nextprevious\" href = \"#{name_for_link}_clasificated_by_color_PicExDG_disp_list.html\">Clasificated by color</a>"
		if name_for_link != "PicExDGAllImgs" then
			pagefile.puts "<a id = \"top_button\" href = \"#{name_for_link}_slideshow_Citra_David_Konstantin_4337387520121220_page.html\">Go to the slideshow</a>"
		else
			pagefile.puts "<a id = \"top_button\" href = \"../index.html\">Go to the slideshow</a>"
		end
		pagefile.puts "</div>"
		pagefile.close
	end
	def create_PicExDGAllImgs_page(page_name,name_for_link)
		pagefile = File.new("html/#{page_name}.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">\n\t\n\t\t<script src=\"themes/5/smooth-scroll.js\"></script><link rel=\"stylesheet\" type=\"text/css\" href=\"lightbox/lightbox.css\" media=\"screen\" /><script type=\"text/javascript\" src=\"lightbox/lightbox.js\"></script></head>\n\t<body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"logo.png\"/></a></div><div id=\"buttons\"><a id = \"nextprevious\" href = \"#{name_for_link}_clasificated_by_color_PicExDG_disp_list.html\">Clasificated by color</a><a id = \"top_button\" href = \"../index.html\">Go to the slideshow</a></div>"
		pagefile.close
	end
	def create_page_color_clasificated(page_name,base_page)
		pagefile = File.new("html/#{page_name}.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">\n\t\n\t\t<script src=\"themes/5/smooth-scroll.js\"></script><link rel=\"stylesheet\" type=\"text/css\" href=\"lightbox/lightbox.css\" media=\"screen\" /><script type=\"text/javascript\" src=\"lightbox/lightbox.js\"></script></head>\n\t<body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"logo.png\"/></a></div><div id=\"buttons\"><a id = \"previous_b\" href = \"#{base_page}.html\">Prev</a>"
		pagefile.close
	end
	def create_color_list(page_name)
		pagefile = File.new("html/#{page_name}_clasificated_by_color_PicExDG_disp_list.html", "w+")
		pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">\n\t<script src=\"themes/5/smooth-scroll.js\"></script></head>\n\t<body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"logo.png\"/></a></div>"
		pagefile.close
	end
	def create_main_page(name)
		pagefile = File.new("#{name}.html", "w+")
		pagefile.puts "<!DOCTYPE html><html><head><meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\"><title>Citra homepage</title><link href=\"html/themes/5/js-image-slider.css\" rel=\"stylesheet\" type=\"text/css\" /><link href=\"html/css/main.css\" rel=\"stylesheet\" type=\"text/css\" /><script src=\"html/themes/5/smooth-scroll.js\"></script><script src=\"html/themes/5/js-image-slider.js\" type=\"text/javascript\"></script><link href=\"generic.css\" rel=\"stylesheet\" type=\"text/css\" /></head><body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"html/logo.png\"/></a></div><div id=\"buttons\"><a id = \"nextprevious\" href = \"index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\">Go to main gallery</a></div><div class = \"main_page\"><div id=\"sliderFrame\"><div id=\"slider\">"
		pagefile.close
	end
	def create_slideshow_page(name)
		pagefile = File.new("#{name}.html", "w+")
		pagefile.puts "<!DOCTYPE html><html><head><meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\"><title>Citra homepage</title><link href=\"themes/5/js-image-slider.css\" rel=\"stylesheet\" type=\"text/css\" /><link href=\"css/main.css\" rel=\"stylesheet\" type=\"text/css\" /><script src=\"themes/5/smooth-scroll.js\"></script><script src=\"themes/5/js-image-slider.js\" type=\"text/javascript\"></script><link href=\"generic.css\" rel=\"stylesheet\" type=\"text/css\" /></head><body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"logo.png\"/></a></div>"
		pagefile.close
	end
end
Html.new.create_index_page
Dir.glob("#{Dir.pwd}/config/*.citra_config_file_23987") do |my_config_file|
	only_name = my_config_file.split("/").last.split(".citra_config_file_23987").first
	if (only_name != "PicExDGAllImgs") then
		Html.new.create_page(only_name,only_name)
	else
		Html.new.create_PicExDGAllImgs_page(only_name,only_name)
	end
	Html.new.create_color_list(only_name)
end

album_counter = 0
page_counter = 2
page_counter2 = 2
photo_counter = 0
page_name = "index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html"
page_name2 = "example.html"
my_config_file_prev_name = String.new
Dir.glob("#{Dir.pwd}/config/*.citra_config_file_23987") do |my_config_file|
	if my_config_file.split(/\//).last == "PicExDGAllImgs.citra_config_file_23987" then
		Html.new.create_main_page("index")
		main_pagefile = File.new("index.html", "a+")
	else
		Html.new.create_slideshow_page("html/#{my_config_file.split(/\//).last.split(".citra_config_file_23987").first}_slideshow_Citra_David_Konstantin_4337387520121220_page")
		main_pagefile = File.new("html/#{my_config_file.split(/\//).last.split(".citra_config_file_23987").first}_slideshow_Citra_David_Konstantin_4337387520121220_page.html", "a+")
		main_pagefile.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file.split(/\//).last.split(".citra_config_file_23987").first}.html\">Prev</a><a id = \"nextprevious\" href = \"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\">Go to main gallery</a></div><div class = \"main_page\"><div id=\"sliderFrame\"><div id=\"slider\">\n"
	end
	text=File.open(my_config_file).read
	text.gsub!(/\r\n?/, "\n")
	tumbs_array = Array.new
	text.each_line do |line|
		if only_photos_with_suitable_dimenssions == "yes" then
			if (line.split("*sep*")[4].to_i >= 700) and (line.split("*sep*")[5].to_i >= 500) then
				if my_config_file.split(/\//).last == "PicExDGAllImgs.citra_config_file_23987" then
					if (line.split("*sep*")[5].to_i <= max_lightbox_pixel_height) or (keep_hds == "no") then
						main_pagefile.puts "<a href=\"html/#{line.split("*sep*")[0]}\" target=\"blank\"><img src=\"html/#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
					else
						main_pagefile.puts "<a href=\"html/hd/#{line.split("*sep*")[0].split("original/").last}\" target=\"blank\"><img src=\"html/#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
					end
					tumbs_array << "html/#{line.split("*sep*")[7]}"
				else
					if (line.split("*sep*")[5].to_i <= max_lightbox_pixel_height) or (keep_hds == "no") then
						main_pagefile.puts "<a href=\"#{line.split("*sep*")[0]}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
					else
						main_pagefile.puts "<a href=\"hd/#{line.split("*sep*")[0].split("original/").last}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
					end
					tumbs_array << "#{line.split("*sep*")[7]}"
				end
			end
		else
			if my_config_file.split(/\//).last == "PicExDGAllImgs.citra_config_file_23987" then
				if (line.split("*sep*")[5].to_i <= max_lightbox_pixel_height) or (keep_hds == "no") then
					main_pagefile.puts "<a href=\"html/#{line.split("*sep*")[0]}\" target=\"blank\"><img src=\"html/#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
				else
					main_pagefile.puts "<a href=\"html/hd/#{line.split("*sep*")[0].split("original/").last}\" target=\"blank\"><img src=\"html/#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
				end
				tumbs_array << "html/#{line.split("*sep*")[7]}"
			else
				if (line.split("*sep*")[5].to_i <= max_lightbox_pixel_height) or (keep_hds == "no") then
					main_pagefile.puts "<a href=\"#{line.split("*sep*")[0]}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
				else
					main_pagefile.puts "<a href=\"hd/#{line.split("*sep*")[0].split("original/").last}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{line.split("*sep*")[9]}]\" /></a>\n"
				end
				tumbs_array << "#{line.split("*sep*")[7]}"
			end
		end
	end
	main_pagefile.puts "</div>"
	main_pagefile.puts "<div id=\"thumbs\">"
	tumbs_array.each do |thumb_address|
		if thumb_address.split("/").first == "html" then
			main_pagefile.puts "<div class=\"thumb\"><img src=\"html/mini_thumbs/#{thumb_address.split("album_preview/").last}\" /></div>\n"
		else
			main_pagefile.puts "<div class=\"thumb\"><img src=\"mini_thumbs/#{thumb_address.split("album_preview/").last}\" /></div>\n"
		end
	end
	tumbs_array.clear
	main_pagefile.puts "</div>"
	main_pagefile.puts "</div></div></body></html>"
	main_pagefile.close
	
	colors_info = Hash.new(0)
	page_counter2 = 2
	i = 0
	k = 0
	if (album_counter > 0) then
		pagefile = File.new(page_name, "a+")
		if my_config_file_prev_name != "PicExDGAllImgs" then
			pagefile.puts "</p></a></div>"
			pagefile.puts "</td>"
		end
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
	my_config_file = my_config_file.split("/").last.split(".citra_config_file_23987").first
	color_list_page_name = "html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list.html"
	color_list_page = File.new(color_list_page_name, "a+")
	color_list_page.puts "<table><tr>"
	td_color_list_page_counter = 0
	colors_info.each do |color,number|
		color_list_page.puts "<td><div class = \"index_album\"><a href = \"#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color}.html\" ><p id = \"title\">#{color} <br>[#{number} photos]</br></p><p><img src=\"colors/#{color}.jpg\" alt=\"#{color}\" id=\"index_photo\"/></p></a></div></td>"
		Html.new.create_page_color_clasificated("#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color}","#{my_config_file}_clasificated_by_color_PicExDG_disp_list")
		Html.new.create_slideshow_page("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color}_slideshow")
		slideshow_pagefile = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color}_slideshow.html", "a+")
		slideshow_pagefile.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color}.html\">Prev</a><a id = \"nextprevious\" href = \"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\">Go to main gallery</a></div><div class = \"main_page\"><div id=\"sliderFrame\"><div id=\"slider\">\n"
		slideshow_pagefile.close
		td_color_list_page_counter += 1
		if td_color_list_page_counter == 4 then
			color_list_page.puts "</tr><tr>"
			td_color_list_page_counter = 0
		end
	end
	if td_color_list_page_counter == 4 then
		color_list_page.puts "</tr>"
	end
	color_list_page.puts "</table><div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}.html\">Prev</a></div>#{put_me_to_the_bottom}#{40000}#{put_me_to_the_bottom2}</body></html>"
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
	photo_counter_with_that_color_sumed = Hash.new(1)
	tumbs_color_page = Hash.new(Array.new)
	if my_config_file.split(/\//).last == "PicExDGAllImgs" then
		album_counter = album_counter - 1
		if td_counter > 2 then
			td_counter = td_counter - 1
		end
	end
	text.each_line do |line|
		color_from_current_line = line.split("*sep*")[9]
		photo_counter = photo_counter + 1
		if page_counter_with_that_color[color_from_current_line] == 1 then
			page_with_images_in_current_color = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}.html", "a+")
		else
			page_with_images_in_current_color = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}#{page_counter_with_that_color[color_from_current_line]}.html", "a+")
		end
		if photo_counter_with_that_color[color_from_current_line] == 1 then
			page_with_images_in_current_color.puts "<div id=\"buttons\"><a id = \"nextprevious\" href = \"#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}_slideshow.html\">Go to the slideshow</a></div>"
			random = Random.rand(5)
			if (random == 1) then
				page_with_images_in_current_color.puts "\t\t<div class = \"album2\">"
			else
				page_with_images_in_current_color.puts "\t\t<div class = \"album\">"
			end	
		end
		if only_photos_with_suitable_dimenssions == "yes" then
			if (line.split("*sep*")[4].to_i >= 700) and (line.split("*sep*")[5].to_i >= 500) then
				color_page_slideshow = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}_slideshow.html","a+")
				if (line.split("*sep*")[5].to_i <= max_lightbox_pixel_height) or (keep_hds == "no") then
							color_page_slideshow.puts "<a href=\"#{line.split("*sep*")[0]}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{color_from_current_line}]\" /></a>\n"
				else
					color_page_slideshow.puts "<a href=\"hd/#{line.split("*sep*")[0].split("original/").last}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{color_from_current_line}]\" /></a>\n"
				end
				color_page_slideshow.close
				tumbs_color_page[color_from_current_line] += ["#{line.split("*sep*")[7]}"]
			end
		else
			color_page_slideshow = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}_slideshow.html","a+")
			if (line.split("*sep*")[5].to_i <= max_lightbox_pixel_height) or (keep_hds == "no") then
						color_page_slideshow.puts "<a href=\"#{line.split("*sep*")[0]}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{color_from_current_line}]\" /></a>\n"
			else
				color_page_slideshow.puts "<a href=\"hd/#{line.split("*sep*")[0].split("original/").last}\" target=\"blank\"><img src=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]} [#{line.split("*sep*")[2]} #{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px #{color_from_current_line}]\" /></a>\n"
			end
			color_page_slideshow.close
			tumbs_color_page[color_from_current_line] += ["#{line.split("*sep*")[7]}"]
		end
		if (photo_counter_with_that_color[color_from_current_line] <= pics_on_page_num-1) then
			random = Random.rand(2)
			if (random == 1) then
				page_with_images_in_current_color.puts "\t\t\t#{line.split("*sep*")[6].split(" ").first}<a id=\"images_and_date\" href=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]}\" rel=\"lightbox\"><img src=\"#{line.split("*sep*")[8]}\" alt=\"#{line.split("*sep*")[1]}\" id=\"gallery_photo\" title = \"#{line.split("*sep*")[1][0..20]}..#{line.split("*sep*")[0][-4..-1]} [#{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px]\"/></a>"
			else
				page_with_images_in_current_color.puts "\t\t\t<a id=\"images_and_date\" href=\"#{line.split("*sep*")[0]}\" alt=\"#{line.split("*sep*")[1]}\" rel=\"lightbox\"><img src=\"#{line.split("*sep*")[8]}\" alt=\"#{line.split("*sep*")[1]}\" id=\"gallery_photo\" title = \"#{line.split("*sep*")[1][0..20]}..#{line.split("*sep*")[0][-4..-1]} [#{line.split("*sep*")[4]}px X #{line.split("*sep*")[5]}px]\"/></a>#{line.split("*sep*")[6].split(" ").first}"
			end
			if photo_counter_with_that_color[color_from_current_line] == pics_on_page_num-1 then
				page_with_images_in_current_color.puts "\t\t</div>"
				if page_counter_with_that_color[color_from_current_line]*photo_counter_with_that_color[color_from_current_line] < colors_info[color_from_current_line] then
					page_with_images_in_current_color.puts "<a id = \"next_b\" href = \"#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}#{page_counter_with_that_color[color_from_current_line]+1}.html\">Next</a></div>"
					page_with_images_in_current_color.puts "#{put_me_to_the_bottom}#{pics_on_page_num*2500}#{put_me_to_the_bottom2}</body></html>"
					if page_counter_with_that_color[color_from_current_line] == 1 then
						Html.new.create_page_color_clasificated("#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}#{page_counter_with_that_color[color_from_current_line]+1}","#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}")
					else
						Html.new.create_page_color_clasificated("#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}#{page_counter_with_that_color[color_from_current_line]+1}","#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}#{page_counter_with_that_color[color_from_current_line]}")
					end
					page_counter_with_that_color[color_from_current_line] += 1
				end
				photo_counter_with_that_color[color_from_current_line] = 0
			end
			if photo_counter_with_that_color_sumed[color_from_current_line] == colors_info[color_from_current_line]
				page_with_images_in_current_color.puts "#{put_me_to_the_bottom}#{pics_on_page_num*2500}#{put_me_to_the_bottom2}</body></html>"
				color_page_slideshow = File.new("html/#{my_config_file}_clasificated_by_color_PicExDG_disp_list_#{color_from_current_line}_slideshow.html","a+")
				color_page_slideshow.puts "</div><div id=\"thumbs\">"
				tumbs_color_page["#{color_from_current_line}"].each {|thumb_address|
						color_page_slideshow.puts "<div class=\"thumb\"><img src=\"mini_thumbs/#{thumb_address.split("album_preview/").last}\" /></div>\n"
				}
				color_page_slideshow.puts "</div></div></div></body></html>"
				color_page_slideshow.close
			end
			photo_counter_with_that_color[color_from_current_line] += 1
			photo_counter_with_that_color_sumed[color_from_current_line] += 1
		end
		page_with_images_in_current_color.close
		if (photo_counter == pics_on_page_num) then #the number of the pics in gallery + 1
			pagefile2.puts "\t\t</div>"
			if ((page_counter2 != 3) and (page_counter2 != 2)) then
				pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter2-2}.html\">Prev</a>"
			else
				if (page_counter2 == 2) then
					if (page_counter != 3)
						pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter - 1}.html\">Prev</a>"
					end
				else
					pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}.html\">Prev</a>"
				end
			end
			pagefile2.puts "<a id = \"next_b\" href = \"#{my_config_file}_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter2}.html\">Next</a></div>"
			pagefile2.puts "#{put_me_to_the_bottom}#{pics_on_page_num*2500}#{put_me_to_the_bottom2}</body></html>"
			pagefile2.close
			Html.new.create_page("#{my_config_file}_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter2}","#{my_config_file}")
			page_name2 = "#{my_config_file}_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter2}.html"
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
			previous = "index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter - 2}.html"
			if album_counter < 5 then
				album_counter_copy = album_counter
				last_value = 0
				while album_counter_copy > 0
					last_value = album_counter_copy
					album_counter_copy = album_counter_copy - 4
				end
				if (last_value > 0) and (last_value < 4) then
					for i in 0..(4-last_value) do
						pagefile.puts "<td></td>"
					end
				end
			end
			if (page_name != "index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html") then
				pagefile.puts "</tr></table>"
				td_counter = 0
				pagefile.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{previous}\">Prev</a>"
			else
				pagefile.puts "</tr></table>"
				td_counter = 0
				pagefile.puts "<div id=\"buttons\">"
			end
			page_name = "index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter}.html"
			pagefile.puts "<a id = \"next_b\" href = \"#{page_name}\">Next</a></div>"
			pagefile.puts "#{put_me_to_the_bottom}#{albums_num*1250}#{put_me_to_the_bottom2}</body></html>"
			pagefile.close
			pagefile = File.new(page_name, "w+")
			pagefile.puts "<html>\n\t<head>\n\t\t<meta content=\"text/html; charset=UTF-8;\" http-equiv=\"content-type\">\n\t\t<title>\n\t\t\tPicExDG\n\t\t</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"html/css/main.css\">\n\t<script src=\"html/themes/5/smooth-scroll.js\"></script></head>\n\t<body><a data-scroll href=\"#bazinga\">Go to the bottom</a><span id=\"bazinga2\"></span><div id=\"logo\"><a href=\"index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_1.html\" target=\"blank\"><img src=\"html/logo.png\"/></a></div>"
			album_counter = 1
			page_counter = page_counter + 1
			pagefile.puts "<div id=\"buttons\"><a id = \"nextprevious\" href = \"html/PicExDGAllImgs.html\">All photos in gallery [#{all_addresses} photos]</a></div>"
			pagefile.puts "<table><tr>"
			pagefile.close
		end
		if (i == 1) and (my_config_file.split(/\//).last != "PicExDGAllImgs") then
			pagefile = File.new(page_name, "a+")
			pagefile.puts "<td>"
			pagefile.puts "<div class = \"index_album\"><a href = \"html/#{line.split("*sep*")[2]}.html\" ><p id = \"title\">#{line.split("*sep*")[2]} <br>[#{k} photos]</br></p><p>"
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
				if (temp_index <= album_preview_num) and (my_config_file.split(/\//).last != "PicExDGAllImgs") then
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
		pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter2 - 2}.html\">Prev</a></div>"
	else
		if page_counter2 == 3 then
			pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"#{my_config_file}.html\">Prev</a></div>"
		end
		if page_counter2 == 2 then
				pagefile2.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"../index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter-1}.html\">Prev</a></div>"
		end
	end
	pagefile2.puts "#{put_me_to_the_bottom}#{pics_on_page_num*2500}#{put_me_to_the_bottom2}</body></html>"
	pagefile2.close
	photo_counter = 0
	my_config_file_prev_name = my_config_file
end

pagefile = File.new(page_name, "a+")
pagefile.puts "</p></a></div>"
pagefile.puts "</td>"
album_counter_copy = album_counter
last_value = 0
while album_counter_copy > 0
	last_value = album_counter_copy
	album_counter_copy = album_counter_copy - 4
end
if (last_value > 0) and (last_value < 4) then
	for i in 0..(4-last_value) do
		pagefile.puts "<td></td>"
	end
end
pagefile.puts "</tr></table>"
td_counter = 0
if page_counter > 2 then
	pagefile.puts "<div id=\"buttons\"><a id = \"previous_b\" href = \"index_CiTra_David_kosio_dsflfjsdhkvhvbsklslkjdslkjg_3458574359_page_number_#{page_counter - 2}.html\">Prev</a></div>"
end
pagefile.puts "#{put_me_to_the_bottom}#{albums_num*1250}#{put_me_to_the_bottom2}</body></html>"
pagefile.close
