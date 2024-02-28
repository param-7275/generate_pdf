class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :marks

      t.timestamps
    end
  end
end
