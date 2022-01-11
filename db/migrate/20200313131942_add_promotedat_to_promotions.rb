class AddPromotedatToPromotions < ActiveRecord::Migration[6.0]
  def change
  	add_column :promotions, :promoted_at, :date
  end
end
