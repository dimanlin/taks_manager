class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include StateMachine

  has_many :tasks, dependent: :destroy

  def update_password!(current_password, new_password, confirm_password)
    unless valid_password?(current_password)
      errors.add(:current_password, "не верный.")
      return false
    end

    reset_password!(new_password, confirm_password)
  end
end
