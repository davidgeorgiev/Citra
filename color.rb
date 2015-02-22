require 'rmagick'
class Color
	def avg_from_image(image_address)
		img =  Magick::Image.read(image_address).first
		pix = img.scale(1, 1)
		averageColor = pix.pixel_color(0,0)
		avgcolor = averageColor.to_s
		avgcolor = avgcolor.split(", ")
		red = (avgcolor[0].split("red=").last.to_i)/(Magick::QuantumRange/255)
		green = (avgcolor[1].split("green=").last.to_i)/(Magick::QuantumRange/255)
		blue = (avgcolor[2].split("blue=").last.to_i)/(Magick::QuantumRange/255)
		rgb = [red,green,blue]
	end
	def rgb_to_hsv(rgb)
		r = rgb[0] / 255.0
		g = rgb[1] / 255.0
		b = rgb[2] / 255.0
		max = [r, g, b].max
		min = [r, g, b].min
		delta = max - min
		v = max * 100
		 
		if (max != 0.0)
			s = delta / max *100
		else
			s = 0.0
		end
		 
		if (s == 0.0) 
			h = 0.0
		else
			if (r == max)
				h = (g - b) / delta
			elsif (g == max)
				h = 2 + (b - r) / delta
			elsif (b == max)
				h = 4 + (r - g) / delta
			end
		 
			h *= 60.0
	
			if (h < 0)
				h += 360.0
			end
		end
		[h,s,v]
	end
	def classificate_the_color(hsv)
		if (hsv[1] >= 0 and hsv[1] <= 25) and (hsv[2] >= 75 and hsv[2] <= 100)
			return "white"
		end
		if (hsv[1] >= 0 and hsv[1] <= 25) and (hsv[2] >= 50 and hsv[2] <= 75)
			return "light gray"
		end
		if (hsv[1] >= 0 and hsv[1] <= 25) and (hsv[2] >= 25 and hsv[2] <= 50)
			return "dark gray"
		end
		if (hsv[1] >= 0 and hsv[1] <= 25) and (hsv[2] >= 0 and hsv[2] <= 25)
			return "black"
		end
		if ((hsv[0] >= 0 and hsv[0] <= 7) or (hsv[0] > 345 and hsv[0] <= 360)) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=63 and hsv[2] <=100)
			return "high red"
		end
		if ((hsv[0] >= 0 and hsv[0] <= 7) or (hsv[0] > 345 and hsv[0] <= 360)) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=63)
			return "low red"
		end
		if (hsv[0] > 7 and hsv[0] <= 31) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=63 and hsv[2] <=100)
			return "high orange"
		end
		if (hsv[0] > 7 and hsv[0] <= 31) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=63)
			return "low orange"
		end
		if (hsv[0] > 31 and hsv[0] <= 60) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=50 and hsv[2] <=100)
			return "yellow"
		end
		if (hsv[0] > 31 and hsv[0] <= 60) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=50)
			return "brown"
		end
		if (hsv[0] > 60 and hsv[0] <= 135) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=63 and hsv[2] <=100)
			return "high green"
		end
		if (hsv[0] > 60 and hsv[0] <= 135) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=63)
			return "low green"
		end
		if (hsv[0] > 135 and hsv[0] <= 190) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=63 and hsv[2] <=100)
			return "high cyan"
		end
		if (hsv[0] > 135 and hsv[0] <= 190) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=63)
			return "low cyan"
		end
		if (hsv[0] > 190 and hsv[0] <= 255) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=63 and hsv[2] <=100)
			return "high blue"
		end
		if (hsv[0] > 190 and hsv[0] <= 255) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=63)
			return "low blue"
		end
		if (hsv[0] > 255 and hsv[0] <= 300) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=63 and hsv[2] <=100)
			return "high magenta"
		end
		if (hsv[0] > 255 and hsv[0] <= 300) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=63)
			return "low magenta"
		end
		if (hsv[0] > 300 and hsv[0] <= 345) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=63 and hsv[2] <=100)
			return "high pink"
		end
		if (hsv[0] > 300 and hsv[0] <= 345) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=33 and hsv[2] <=63)
			return "low pink"
		end
		
		if ((hsv[0] >= 0 and hsv[0] <= 7) or (hsv[0] > 345 and hsv[0] <= 360)) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark red"
		end
		if (hsv[0] > 7 and hsv[0] <= 31) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark orange"
		end
		if (hsv[0] > 31 and hsv[0] <= 60) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark brown"
		end
		if (hsv[0] > 60 and hsv[0] <= 135) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark green"
		end
		if (hsv[0] > 135 and hsv[0] <= 190) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark cyan"
		end
		if (hsv[0] > 190 and hsv[0] <= 255) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark blue"
		end
		if (hsv[0] > 255 and hsv[0] <= 300) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark magenta"
		end
		if (hsv[0] > 300 and hsv[0] <= 345) and (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=6 and hsv[2] <33)
			return "dark pink"
		end
		
		if (hsv[1] > 25 and hsv[1] <= 100) and (hsv[2] >=0 and hsv[2] <6)
			return "extremely dark colors"
		end
		"nothing"
	end
end
#color = Color.new
#p color.rgb_to_hsv(color.avg_from_image("/home/tehtri/Desktop/IMG-1423236050963-V.jpg"))
#p color.classificate_the_color(color.rgb_to_hsv(color.avg_from_image("/home/tehtri/Desktop/IMG-1423236050963-V.jpg")))





















