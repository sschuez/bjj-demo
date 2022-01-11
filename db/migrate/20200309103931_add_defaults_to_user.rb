class AddDefaultsToUser < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :users, :date_of_birth, ""
  	change_column_default :users, :phone, ""
  	change_column_default :users, :started, ""
  	change_column_default :users, :weight, ""
  	change_column_default :users, :height, ""
  	change_column_default :users, :weight_good, ""
  	change_column_default :users, :reasons_for_weight, ""
  	change_column_default :users, :active_member, true
  	change_column_default :users, :not_active_why, ""
  	change_column_default :users, :belt, ""
  	change_column_default :users, :last_promotion, ""
  end
end
