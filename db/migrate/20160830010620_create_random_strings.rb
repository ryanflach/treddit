class CreateRandomStrings < ActiveRecord::Migration[5.0]
  def change
    create_table :random_strings do |t|
      t.string :word

      t.timestamps
    end
  end
end
