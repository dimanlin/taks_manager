class Dashboard::DashboardController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :auth_by_token
  before_action :authenticate_user!

  layout 'dashboard'

  private

  def auth_by_token
    user = User.find_by_token(params[:token])
    sign_in(:user, user) if user
  end
end
