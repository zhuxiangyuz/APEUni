class Api::V1Controller < ActionController::API
  before_action :authenticate_user!
end