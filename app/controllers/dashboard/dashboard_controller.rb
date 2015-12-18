class Dashboard::DashboardController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }


  before_action :auth_by_token
  before_action :authenticate_user!

  layout 'dashboard'


  private

  def auth_by_token
    if request.format.json?
      user = User.find_by_token(params[:token])
      if user
        sign_in(:user, user)
      else
        render nothing: true, status: 401
      end
    end
  end

end
