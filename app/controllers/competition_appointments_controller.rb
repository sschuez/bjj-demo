class CompetitionAppointmentsController < ApplicationController
	before_action :require_login
	before_action :set_competition_appointment, only: [:show, :edit, :update, :destroy]
	before_action :set_current_user_appointment, only: [:new, :create]

	def new
		set_current_user_appointment
		@competition_appointment = CompetitionAppointment.new
		authorize @competition_appointment	
	end

	def show
		set_competition_appointment
		authorize @competition_appointment
	end

	def create
		set_current_user_appointment
		@competition_appointment = CompetitionAppointment.new(competition_appointment_params)
		authorize @competition_appointment

		@competition_appointment.user = @user
		@competition_appointment.competition = @competition
		@competition_appointment.save
		redirect_to competition_path(@competition)
		flash[:notice] = "Registered #{@user.first_name.upcase} #{@user.last_name.upcase} for #{@competition.name.upcase}"
	end

	def edit
		set_competition_appointment
    authorize @competition_appointment
	end

	def update
		set_competition_appointment
		authorize @competition_appointment

		if @competition_appointment.update(competition_appointment_params)
		  redirect_to competition_path(@competition)
		  flash[:notice] = "Edited registration for competition #{@competition.name.upcase}"
		else
		  render :edit
		end
	end

	def destroy
		set_competition_appointment
		authorize @competition_appointment

		@competition_appointment.destroy
		redirect_to competition_path(@competition)
		flash[:notice] = "Deregistered #{@user.first_name.upcase} #{@user.last_name.upcase} from competition #{@competition.name.upcase}"		
	end

	private

	def set_current_user_appointment
		@user = current_user
		@competition = Competition.find(params[:competition_id])
	end

	def set_competition_appointment
		@user = CompetitionAppointment.find(params[:id]).user
		@competition = Competition.find(params[:competition_id])
		@competition_appointment = CompetitionAppointment.find(params[:id])
	end

	def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # halts request cycle
    end
  end

  def competition_appointment_params
  	params.require(:competition_appointment).permit(:weight_class, :belt_class, :result, :comment)
  end
end
