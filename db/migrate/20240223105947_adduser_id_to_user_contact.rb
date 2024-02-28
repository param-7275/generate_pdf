class AdduserIdToUserContact < ActiveRecord::Migration[7.1]
  def change
    add_column :user_contacts, :user_id, :integer
  end
end
