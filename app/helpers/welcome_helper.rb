module WelcomeHelper
  def assigned_to(task)
    if task.user
      "Назначенна: #{task.user.email}"
    else
      "Не назначенна"
    end
  end
end
