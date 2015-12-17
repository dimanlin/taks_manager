class WelcomeController < ApplicationController
  def index
    @tasks = Task.all.order('created_at desc')
    puts '11111111111111111111'
    puts @tasks.count
  end
end
