class Promotion < ApplicationRecord
  belongs_to :user
  
  # include PgSearch::Model
  # multisearchable against: [ :belt ]
end
