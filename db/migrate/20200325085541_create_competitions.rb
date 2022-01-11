class CreateCompetitions < ActiveRecord::Migration[6.0]
  def change
    create_table :competitions do |t|
      t.string :name
      t.date :date
      t.string :location
      t.text :info
      t.date :registration_start
      t.date :registration_end
      t.string :website

      t.timestamps
    end
  end
end
