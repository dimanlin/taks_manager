class WelcomeController < ApplicationController
  def index
    @tasks = Task.all.order('created_at desc')
  end
end
