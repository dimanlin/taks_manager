class User < ActiveRecord::Base

  include StateMachine
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :tasks, dependent: :destroy

  before_create :generate_api_token

  def update_password!(current_password, new_password, confirm_password)
    unless valid_password?(current_password)
      errors.add(:current_password, "не верный.")
      return false
    end

    reset_password(new_password, confirm_password)
  end

  private

  def generate_api_token
    self.token = SecureRandom.hex(32)
  end
end
