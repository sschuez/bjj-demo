class AddCreatedbyToCompetitions < ActiveRecord::Migration[6.0]
  def change
    add_column :competitions, :created_by, :string
  end
end
