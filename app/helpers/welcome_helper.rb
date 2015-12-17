module WelcomeHelper
  def assigned_to(task)
    if task.user
      content_tag :span do
        content_tag :span do
          content_tag(:span, "Назначенна:") +
          link_to(task.user.email, user_path(task.user))
        end
      end
    else
      "Не назначенна"
    end
  end
end
