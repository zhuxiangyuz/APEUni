class Api::V1Controller < ActionController::API

  def current_user
    @current_user ||= User.find_by(id: params[:user_id])
  end
end