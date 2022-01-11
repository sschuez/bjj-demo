class RemoveBeltFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :belt, :string
  end
end
