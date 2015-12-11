module StateMachine
  extend ActiveSupport::Concern

  included do
    enum state: { fresh: 0, started: 1, finished: 2 }
  end
end