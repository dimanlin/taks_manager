class Task < ActiveRecord::Base
  include StateMachine

  validates :name, :description, presence: true

  has_many :attachments
  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  def assign_to(user)
    update(user_id: user.id)
  end
end
