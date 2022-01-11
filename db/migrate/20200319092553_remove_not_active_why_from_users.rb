class RemoveNotActiveWhyFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :not_active_why, :string
  end
end
