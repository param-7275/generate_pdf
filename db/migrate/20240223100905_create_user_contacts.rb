class CreateUserContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_contacts do |t|
      t.string :name
      t.string :contact
      t.string :message

      t.timestamps
    end
  end
end
