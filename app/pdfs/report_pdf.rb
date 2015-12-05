# from video

class ReportPdf < Prawn::Document
  def initialize(user)
   	super()
    @users = User.all
    @attendances = Attendance.all
    @employees = Employee.all
    header
    text_content
    list
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/logo.png", width: 75, height: 75
  end
  
	def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50
    ad_position = cursor - 10

		bounding_box([300, ad_position], :width => 270, :height => 100) do
      text "Rekwup SCRL", size: 15, style: :bold
      text "5590 Ciney (Belgium) "
      text "Tel:	+32 487 698 373 "
      text "email: "
      text "Site: http://www.rekwup.be"
    end


    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 270, :height => 50) do
      text "Rapport de la semaine #{6.days.ago.beginning_of_week.strftime("%W")}", size: 15, style: :bold
      text "Du lundi #{6.days.ago.beginning_of_week.strftime("%d/%m/%Y")} au dimanche #{(6.days.ago.beginning_of_week + 6.days).strftime("%d/%m/%Y")}"
      # @employees.each do |employee|
      # 	"#{employee.name}"
      # end
    end


    

	end

	# def table_content
 #    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
 #    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
 #    # Then I set the table column widths
 #    table employee_rows do
 #      row(0).font_style = :bold
 #      self.header = true
 #      self.row_colors = ['DDDDDD', 'FFFFFF']
 #      self.column_widths = [300, 200]
 #    end
 #  end

 #  def employee_rows
 #    [['Name', 'Full_name']] +
 #      @employees.map do |employee|
 #      [employee.name, employee.full_name]
 #    end
 #  end
	

	def list
		y_position = cursor - 55
		@employees.where(:status => "Interim").each do |employee|
			if employee.duration_entree_last_week > 0
			  text "#{employee.full_name}", :size => 12, :style => :bold, :spacing => 4
			  move_down 5
			  text "Lun #{6.days.ago.beginning_of_week.strftime("%d/%m/%Y")}         #{employee.display_duration_entree_last_monday}", :size => 10
			  text "Mar #{(6.days.ago.beginning_of_week + 1.day).strftime("%d/%m/%Y")}         #{employee.display_duration_entree_last_tuesday}", :size => 10
			  text "Mer #{(6.days.ago.beginning_of_week + 2.days).strftime("%d/%m/%Y")}         #{employee.display_duration_entree_last_wednesday}", :size => 10
			  text "Jeu #{(6.days.ago.beginning_of_week + 3.days).strftime("%d/%m/%Y")}         #{employee.display_duration_entree_last_thursday}", :size => 10
			  text "Ven #{(6.days.ago.beginning_of_week + 4.days).strftime("%d/%m/%Y")}         #{employee.display_duration_entree_last_friday}", :size => 10
			  text "Sam #{(6.days.ago.beginning_of_week + 5.days).strftime("%d/%m/%Y")}        #{employee.display_duration_entree_last_saturday}", :size => 10
			  text "Dim #{(6.days.ago.beginning_of_week + 6.days).strftime("%d/%m/%Y")}         #{employee.display_duration_entree_last_sunday}", :size => 10
			  move_down 5
			  text "Total Semaine:      #{employee.display_duration_entree_last_week}", :size => 12, :style => :bold, :spacing => 4
			  move_down 10
			end
		end
	end
end