class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :link_karma
      t.integer :comment_karma
      t.text :token

      t.timestamps
    end
  end
end
