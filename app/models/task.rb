class Task < ActiveRecord::Base
  include StateMachine

  validates :name, :description, presence: true

  has_many :attachments
  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true

  def assign_to(user)
    update(user_id: user.id)
  end
end
