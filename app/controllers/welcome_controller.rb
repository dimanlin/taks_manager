class WelcomeController < ApplicationController
  def index
    @tasks = Task.order('created_at desc').page(params[:page]).per(10)
  end
end
