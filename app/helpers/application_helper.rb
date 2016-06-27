module ApplicationHelper

	def format_date(f)
		(f.day<10 ? "0" : "")+f.day.to_s+"/"+
		(f.month<10 ? "0" : "" )+f.month.to_s+"/"+
		f.year.to_s + " a las "+
		(f.hour<10 ? "0" : "")+f.hour.to_s + ":"+
		(f.min<10 ? "0": "")+f.min.to_s
	end

	def format_date_to_file(f)
		f.year.to_s +
		(f.month<10 ? "0" : "" )+f.month.to_s+
		(f.day<10 ? "0" : "")+f.day.to_s
		
	end

	def get_hour_of_date(f)
		(f.hour<10 ? "0" : "")+f.hour.to_s + ":"+
		(f.min<10 ? "0": "")+f.min.to_s
	end


	def format_id(id,count)
		r=id.to_s
		while r.size < count  do
			r="0"+r
		end
		return r
	end

	def format_price(p)
		puts "format_price begin"
		puts "precio recibido::"+p.to_s
		formatted='%.2f' % p.to_s
		puts "first formatted::"+formatted.to_s
		formatted=formatted.sub! '.', ','
		puts "second formatted::"+formatted.to_s

		miles = formatted[0,formatted.size-3]
		puts "(miles.length/3).to_i::"+(miles.length/3).to_s
		if miles.size>3
			puts "miles::"+miles
			index = miles.length-3;
			for i in 0..(miles.length/3).to_i
				puts "index::"+index.to_s
				if index>0
					puts "init formatted::"+formatted.to_s
					formatted = formatted.insert(index,".");
					index -=3;
					puts "fin formatted::"+formatted.to_s

				end
			end
		end

		#0.formatted	
		return formatted + " Bs."
	end
end
