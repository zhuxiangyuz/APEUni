class Api::V1::WordsController < Api::V1Controller

  def index
    @words = Word.preload(:learn_words)
    @words = @words.where(word_book_id: params[:word_book_id])
    @words = @words.joins("LEFT JOIN learn_words on words.id = learn_words.word_id AND learn_words.user_id = #{current_user.id}")
                    .select("words.*, last_reviewed_at")
    @words = @words.order("last_reviewed_at #{params[:order]}") if params[:order].present?
    @words = @words.where("word like :keyword or alternative_spellings like :keyword", keyword: "%#{params[:keyword]}%") if params[:keyword].present?
  end

  def create
    word = Word.new(
      word: params[:word],
      word_book_id: params[:word_book_id],
      alternative_spellings: params[:alternative_spellings],
      meaning: params[:meaning],
      pronunciation: params[:pronunciation],
      example_sentence: params[:example_sentence]
    )
    if word.save
      render json: { message: "Word created successfully", status: 201 }
    else
      render json: { message: word.errors.full_messages, status: 400 }
    end
  rescue => error
    render json: { message: error, status: 400 }
  end

  def mastered
    word = Word.find_by(id: params[:word_id], word_book_id: params[:word_book_id])
    mastered_word = word.learn_word(current_user.id)
    if word.present? && mastered_word.present?
      mastered_word.update(
        mastered: params[:mastered],
        last_reviewed_at: params[:mastered] == "1" ? Time.now.to_i : nil
      )
    else
      learn_words
    end
    render json: { message: "Modification succeeded", status: 200 }
  rescue => error
    render json: { message: error, status: 400 }
  end

  def destroy
    word = Word.find_by(id: params[:word_id])
    word.destroy if word.present?
    render json: { message: "Deletion succeeded", status: 204 }
  end

  private

  def learn_words
    learn_word = LearnWord.new(
      user_id: current_user.id,
      word_id: params[:word_id],
      word_book_id: params[:word_book_id],
      mastered: params[:mastered],
      last_reviewed_at: params[:mastered] == "1" ? Time.now.to_i : nil
    )
    learn_word.save
  end

end