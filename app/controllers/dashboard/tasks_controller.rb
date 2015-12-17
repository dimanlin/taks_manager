class Dashboard::TasksController < Dashboard::DashboardController

  def index
    @tasks = current_user.tasks
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to dashboard_task_path(@task)
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
      redirect_to dashboard_task_path(@task)
    else
      render action: :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :state, :user_id)
  end
end
