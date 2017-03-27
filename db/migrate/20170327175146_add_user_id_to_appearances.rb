class AddUserIdToAppearances < ActiveRecord::Migration[5.0]
  def change
    add_column :appearances, :user_id, :integer
  end
end
