class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :phone, :string
    add_column :users, :started, :date
    add_column :users, :weight, :integer
    add_column :users, :height, :integer
    add_column :users, :weight_good, :boolean
    add_column :users, :reasons_for_weight, :string
    add_column :users, :active_member, :boolean
    add_column :users, :not_active_why, :string
    add_column :users, :belt, :string
    add_column :users, :last_promotion, :date
  end
end
