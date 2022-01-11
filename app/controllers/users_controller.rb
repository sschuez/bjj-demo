class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	helper_method :sort_column, :sort_direction

	def index
		if params["search"]
      @filter = params["search"]["active_member"].concat(params["search"]["sex"]).concat(params["search"]["belt"]).flatten.reject(&:blank?)
      @users = policy_scope(User.all.global_search("#{@filter}").order(first_name: :desc))
    elsif params[:query].present?
    	sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
	  	@users = policy_scope(User.where(sql_query, query: "%#{params[:query]}%"))
    else
      @users = policy_scope(User.order(sort_column + " " + sort_direction)) # Sorting logic currently not used.
    end
    respond_to do |format|
      format.html
      format.js
    end

    #.concat(params["search"]["weight"]).concat(params["search"]["height"])

		# skip_policy_scope
		
		# Le Wagon search bar and old sort logic
		# if params[:query].present?
		#   sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
		#   @users = policy_scope(User.where(sql_query, query: "%#{params[:query]}%"))
		# else
		#   @users = policy_scope(User.order(sort_column + " " + sort_direction))
		#   # @promotions = policy_scope(Promotion.order(sort_column + " " + sort_direction))

		#   # filters - not used so far!
		# 	# @sex = User.all.pluck(:sex).uniq
		# 	# @active = User.all.pluck(:active_member).uniq
		# 	# @users = @users.where(sex: params[:filter_sex]) if params[:filter_sex].present?
		# 	# @users = @users.where(active_member: params[:filter_active_member]) if params[:filter_active_member].present?
		# end
		
		# @users = User.all

		# if params[:query].present?
		#   sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
		#   @users = User.where(sql_query, query: "%#{params[:query]}%")

		# @search = params[:query]
		# if @search.present?
			# sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
			# @first_name = @search["first_name"]
			# @users = User.where(sql_query, query: "%#{@search}%")

			# @search = params[:query]
		 #    if @search.present?
		 #      @first_name = @search["first_name"]
		 #      @users = User.where(first_name: @first_name)
		 #    end
			# @users = User.where("first_name ILIKE ?", "%#{@first_name}%")
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path(@user),  notice: "Profile successfully updated"
		else
			render :edit
		end 
	end

	def destroy
    @user.destroy

    # no need for app/views/users/destroy.html.erb
    redirect_to root_path, notice: "Profile of #{user_name} successfully deleted"
	end

	def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    # redirect_to root_path
    authorize user
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to users_path, notice: "Stopped impersonating."
    authorize current_user
  end

  

	private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :date_of_birth, :phone, :started, :weight, :height, :weight_good, :active_member, :photo, :sex)
  end

  def set_user
  	@user = User.find(params[:id])
  	authorize @user
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
    # Promotion.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
