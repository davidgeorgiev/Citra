all_addresses = 0
all_addresses_file=File.open('all_addresses.txt').read
all_addresses_file.gsub!(/\r\n?/, "\n")
all_addresses_file.each_line do |line|
		all_addresses = line.split("\n").first.to_i
end
td_counter = -1;
pics_on_page_num = 0
albums_num = 0
album_preview_num = 1
line_num=0
edit_me=File.open('edit_me.txt').read
edit_me.gsub!(/\r\n?/, "\n")
edit_me.each_line do |line|
	if (line.split(":").first == "the number of the albums") then
		albums_num = line.split(":").last.to_i + 1
	end
	if (line.split(":").first == "the number of the pics in gallery on one page") then
		pics_on_page_num = line.split(":").last.to_i + 1
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
