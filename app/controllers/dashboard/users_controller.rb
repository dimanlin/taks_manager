class Dashboard::UsersController < Dashboard::DashboardController
  before_action :init_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_user_path(@user)
    else
      render action: :edit
    end
  end

  def edit_password
  end

  def update_password
    if @user.update_password!(params[:user][:current_password], params[:user][:password], params[:user][:password_confirmation])
      redirect_to root_path
    else
      render action: :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def init_user
    @user = current_user
  end
end
