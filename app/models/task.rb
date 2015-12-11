class Task < ActiveRecord::Base
  include StateMachine

  belongs_to :user
end
