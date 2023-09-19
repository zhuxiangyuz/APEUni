class Word < ActiveRecord::Base

  has_many :learn_words, dependent: :destroy

  belongs_to :word_book

  def learn_word(user_id)
    self.learn_words&.find { |word| word.user_id == user_id }
  end
end