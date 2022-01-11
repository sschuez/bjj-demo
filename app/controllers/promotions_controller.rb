class PromotionsController < ApplicationController

	def index
		@promotions = current_user.promotions
		# @promotions = policy_scope(Promotion.order(sort_column + " " + sort_direction))
	end

	def new
		@user = User.find(params[:user_id])
    @promotion = Promotion.new
    authorize @promotion
	end

	def create
		@promotion = Promotion.new(promotion_params)
		authorize @promotion
		@user = User.find(params[:user_id])
		@promotion.user = @user
		 
		if @user.promotions.empty?
			@promotion.save
		else
			@promotion.belt =	@belts[@belts.index(@user.promotions.last.belt) + 1]
		end

		@promotion.save
		redirect_to user_path(@user)

		@belts.index(@user.promotions.last.belt)
		flash[:notice] = "Successfully promoted #{@user.first_name} to #{@promotion.belt} belt."
	end

	private
	
	def promotion_params
		params.require(:promotion).permit(:belt, :promoted_at)
	end

	# def sort_column
	#   User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
	#   # Promotion.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
	# end
	
	# def sort_direction
	#   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	# end
end