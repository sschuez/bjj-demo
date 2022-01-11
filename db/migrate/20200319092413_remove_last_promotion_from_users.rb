class RemoveLastPromotionFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :last_promotion, :date
  end
end
