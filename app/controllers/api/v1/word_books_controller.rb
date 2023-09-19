class Api::V1::WordBooksController < Api::V1Controller

  def index
    @word_books = WordBook.preload(:words, :learn_words)
    @word_books = @word_books.where(user_id: nil).or(WordBook.where(user_id: current_user.id))
  end
end