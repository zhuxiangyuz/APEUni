json.status 200
json.message "success"
json.data do 
  json.array! @words do |word|
    json.word word.word
    json.alternative_spellings word.alternative_spellings
    json.meaning word.meaning
    json.pronunciation word.pronunciation
    json.example_sentence word.example_sentence
    json.mastered (word.learn_word(current_user.id)&.mastered || 0) == 0 ? "未掌握" : "已掌握"
  end
end