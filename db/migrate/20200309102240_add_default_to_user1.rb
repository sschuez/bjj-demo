class AddDefaultToUser1 < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :users, :first_name, ""
  end
end
