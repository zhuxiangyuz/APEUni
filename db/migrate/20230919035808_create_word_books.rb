class CreateWordBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :word_books do |t|
      t.string :book_name, null: false
      t.integer :user_id, null: false
      t.integer :is_custom, null: false, default: 0, comment: "是否生词本，1：是，0：否"

      t.timestamps
    end
  end
end
