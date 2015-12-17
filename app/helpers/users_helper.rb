module UsersHelper
  def profile_header(user)
    if current_user == user
      'Мой профиль'
    else
      "Профиль #{current_user.email}"
    end
  end
end
