class CreateLearnWords < ActiveRecord::Migration[6.1]
  def change
    create_table :learn_words do |t|
      t.integer :user_id, null: false
      t.integer :word_id, null: false
      t.integer :word_book_id, null: false
      t.integer :mastered, null: false, default: 0, comment: "是否掌握，1：掌握，0：未掌握"
      t.integer :last_reviewed_at

      t.timestamps
    end
  end
end
