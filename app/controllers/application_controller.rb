class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_variable
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :user_name, :current_belt_index, :date_difference_promotion, :last_promotion, :black_belt_progress

  impersonates :user
  
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit(:account_update, keys: update_attrs)
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      users_path
    else	
      user_path(current_user)
    end
  end

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    # if current_user != true_user
      # redirect_to user_path(current_user), notice: "You are now impersonating #{current_user.first_name} #{current_user.last_name}."
    # else
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    # end
  end
  
  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def black_belt_progress
    (((@belts.index(@user.promotions.last.belt) + 1.0) / @belts.length) * 100).floor
  end

  def set_variable
    @belts = ['White', 'White I', 'White II', 'White III', 'White IIII', 'Blue', 'Blue I', 'Blue II', 'Blue III', 'Blue IIII', 'Purple', 'Purple I', 'Purple II', 'Purple III', 'Purple IIII', 'Brown', 'Brown I', 'Brown II', 'Brown III', 'Brown IIII', 'Black']
    @belt_colours = [ 'White', 'Blue', 'Purple','Brown','Black']
    @belt_class = ['White', 'Blue', 'Purple', 'Brown', 'Black']
    @weights = [54, (40..50), (50..60), (60..70), (70..80), (80..90), (90..100)]
    @heights = ["-150", "150-60", "160-70", "170-80", "180-90", "190-200", "200-"]
    @categories = ['personal info', 'membership', 'promotion', 'weight', 'training', 'competition', 'miscellaneous']
    @sex = ['male', 'female', 'undefined']
    @weight_class_male = [
      "Rooster (m) – 57.5 kg",
      "Light Feather (m) – 64 kg",
      "Feather (m) – 70 kg",
      "Light (m) – 76 kg",
      "Middle (m) – 82.3 kg",
      "Medium Heavy (m) – 88.3 kg",
      "Heavy (m) – 94.3 kg",
      "Super-Heavy (m) – 100.5 kg",
      "Ultra Heavy (m) – No Maximum Weight"
    ]
    @weight_class_female = [
      "Light Feather (f) – 53.5 kg ",
      "Feather (f) – 58.5 kg ",
      "Light (f) – 64 kg ",
      "Middle (f) – 69 kg ",
      "Medium Heavy (f) – 74 kg ",
      "Heavy (f) – No Maximum Weight"
    ]

  end

  # Name definition for delete alert message
  def user_name
    if @user.first_name == nil || @user.first_name == ""
      "Name undefined"
    else
      @user.first_name + " " + @user.last_name
    end
  end

  # Where does user stand on belts array in application controller
  def current_belt_index
    if @user.promotions.empty? 
      return 0 
    else 
      @belts.index(@user.promotions.last.belt).to_i 
    end 
  end

  # Difference between promotions
  def date_difference_promotion
    if @user.promotions.empty?
      return 0 
    else 
      (Date.today.year * 12 + Date.today.month) - (last_promotion.year * 12 + last_promotion.month).to_i
    end 
  end

  # Check if promotion date was manually added
  def last_promotion
    if @user.promotions.empty?
      "No belt assigend yet" 
    elsif @user.promotions.last.promoted_at == nil  
      @user.promotions.last.created_at 
    else 
      @user.promotions.last.promoted_at 
    end 
  end

end
