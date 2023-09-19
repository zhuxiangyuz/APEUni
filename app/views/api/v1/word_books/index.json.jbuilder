json.status 200
json.message "success"
json.data do
  json.array! @word_books do |book|
    json.book_name book.book_name
    json.is_custom book.is_custom == 1 ? "生词本" : "单词本"
    json.total_words book.words.size
    json.learn_words book.learn_words.size
  end
end