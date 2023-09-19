class WordBook < ActiveRecord::Base
  has_many :words
  has_many :learn_words, -> { where(mastered: 1) }
end