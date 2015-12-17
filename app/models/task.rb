class Task < ActiveRecord::Base
  include StateMachine

  validates :name, :description, presence: true

  belongs_to :user

  def assign_to(user)
    update(user_id: user.id)
  end
end
