class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :promotions, dependent: :destroy
  has_many :competition_appointments, dependent: :destroy
  has_many :competitions, through: :competition_appointments
  has_one_attached :photo, dependent: :destroy

  include PgSearch::Model 
  pg_search_scope :global_search,
    against: [ :active_member, :sex ],
    associated_against: {
      promotions: [ :belt ]
    },
    using: {
      tsearch: {any_word: true}
    }

    # include PgSearch::Model
    #   multisearchable against: [:sex, :active]
    
  def last_promotion
    if self.promotions.empty?
      return Date.today
    elsif self.promotions.last.promoted_at == nil  
      return self.promotions.last.created_at 
    else 
      return self.promotions.last.promoted_at 
    end 
  end

  def promotion_time
    (Date.today.year * 12 + Date.today.month) - (last_promotion.year * 12 + last_promotion.month).to_i
  end

	def age?
		((Time.zone.now - self.date_of_birth.to_time) / 1.year.seconds).floor         	
	end

	def member_since_months
		months = (Date.today.year - self.started.year) * 12 + Date.today.month - self.started.month - (Date.today.day >= self.started.day ? 0 : 1)
	end         

	def date_diff(date1,date2)
	  month = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
	  month_array = month.divmod(12)
	  if month_array[0] > 0
	  	"#{month_array[0]}y #{month_array[1]}m"
	  else
	  	"#{month_array[1]}m"
	  end
	end



end
