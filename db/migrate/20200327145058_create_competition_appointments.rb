class CreateCompetitionAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :competition_appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :competition, null: false, foreign_key: true
      t.string :weight_class
      t.string :belt_class
      t.integer :result
      t.text :comment

      t.timestamps
    end
  end
end
