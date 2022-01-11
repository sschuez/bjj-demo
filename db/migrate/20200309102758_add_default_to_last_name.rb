class AddDefaultToLastName < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :users, :last_name, ""
  end
end
