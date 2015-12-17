class TasksController < ApplicationController
  def assign_to_me
    @task = Task.find(params[:id])
    @task.assign_to(current_user)
    redirect_to root_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render action: :edit
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      render action: :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :state, :user_id)
  end
end
