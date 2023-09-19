class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :word, null: false
      t.integer :word_book_id, null: false
      t.string :alternative_spellings
      t.string :meaning, null: false
      t.string :pronunciation, null: false
      t.string :example_sentence

      t.timestamps
    end
  end
end
