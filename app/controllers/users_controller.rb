class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @users = User.all
    @attendances = Attendance.all
    @employees = Employee.all

# FROM http://www.sitepoint.com/pdf-generation-rails/

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@users)
        send_data pdf.render, filename: "Semaine_#{6.days.ago.beginning_of_week.strftime("%W")}.pdf",
                              type: 'application/pdf',
                              disposition: "inline"
      end
    end
  end


# FROM http://brandensilva.com/create-a-pdf-invoice-using-prawn-in-rails/
    # respond_to do |format|
    #   format.html
    #  # format.xml
    #   format.pdf # { render :layout => false }
    #   format.pdf do
    #   send_data pdf.render, filename: "Semaine_#{6.days.ago.beginning_of_week.strftime("%W")}.pdf",
    #                         type: "application/pdf",
    #                         disposition: "inline"
    #   end
    # end
   

# FROM VIDEO
      # respond_to do |format|
      # format.html
      # format.pdf do
        # pdf = WeekReport.new
        
        # send_data pdf.render, filename: "Semaine_#{6.days.ago.beginning_of_week.strftime("%W")}.pdf",
        #                       type: "application/pdf",
        #                       disposition: "inline"
      # end
   # end

  def show
    @user = User.find(params[:id])
    @attendance = Attendance.new
    
    # unless @user == current_user
    #   redirect_to :back, :alert => "Access denied."
    # end
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Votre profil a bien été mis à jour.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :first_name)
    end

end
