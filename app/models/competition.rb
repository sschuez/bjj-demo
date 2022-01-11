class Competition < ApplicationRecord
	has_one_attached :photo
	has_many :competition_appointments, dependent: :destroy
	has_many :users, through: :competition_appointments

	scope :upcoming, lambda { where("DATE(date) >= ?", Date.today) }
	scope :past, lambda { where("DATE(date) < ?", Date.today) }

	validates :name, presence: true
	validates :location, presence: true
	validates :date, presence: true
	validates :registration_start, presence: true
	validates :registration_end, presence: true

	include PgSearch::Model 
	pg_search_scope :date_search,
	  against: [ :date ],
	  using: {
	    tsearch: {any_word: true}
	  }

end
