class RemoveReasonsForWeightFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :reasons_for_weight, :string
  end
end
