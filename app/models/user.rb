class User < ActiveRecord::Base
  include StateMachine

  validates :email, :password, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  attr_accessor :password_confirmation

  has_many :tasks, dependent: :destroy
end
