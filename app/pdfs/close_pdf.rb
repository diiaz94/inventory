class ClosePDF < Prawn::Document
		include ApplicationHelper	
	def initialize(file_name,bills,date)
		super(top_margin: 70)
		@bills =bills
		@date=date
		@file_name=file_name
		puts "BILLS :: "+ @bills.to_s
		@total=Bill.where(id:@bills.map(&:id)).sum(:total)
		title_report
		date_report
		bills_table
		total_bills

	end
	def file_name 
		@file_name
	end

	def title_report
		text "Cierre de caja" , size: 25, style: :bold
	end
	def date_report
		text "#{@date.to_s}", align: :right
	end
	def bills_table
		move_down 20
		table bills_table_rows do
			row(0).font_style = :bold
			self.row_colors = ["dcecf5","FFFFFF"]
			columns(0).align = :center
			columns(2..3).align = :center
			columns(1).align = :right
			self.width = 520
			self.header = true
			row(0).align = :center
		end
	end 

	def bills_table_rows
		[["Factura Nro","Total","Vendedor","Hora"]] +

		@bills.map do |item|
			[item.id_formatted,
			 item.total_formatted,
			 item.seller.user.profile.primer_nombre+" "+item.seller.user.profile.primer_apellido,
			 item.hora_c]
		end
	end
	def total_bills
		move_down 20
		text "Total en caja #{format_price(@total.to_s)}" , size: 20, style: :bold
	end
end
