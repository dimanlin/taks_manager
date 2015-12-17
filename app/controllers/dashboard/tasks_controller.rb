class Dashboard::TasksController < Dashboard::DashboardController

  def index
    @tasks = current_user.tasks

    respond_to do |format|
      format.html
      format.json { render layout: false }
    end
  end

  def assign_to_me
    @task = Task.find(params[:id])
    @task.assign_to(current_user)

    respond_to do |format|
      format.html do
        redirect_to root_path
      end
      format.json { render layout: false }
    end
  end

  def edit
    @task = Task.find(params[:id])
    @task.attachments
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      respond_to do |format|
        format.html do
          redirect_to dashboard_task_path(@task)
        end
        format.json { render layout: false }
      end
    else
      respond_to do |format|
        format.html do
          render action: :edit
        end
        format.json { render layout: false }
      end
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @task.attachments.build
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      respond_to do |format|
        format.html do
          redirect_to dashboard_task_path(@task)
        end
        format.json { render layout: false }
      end
    else
      respond_to do |format|
        format.html do
          render action: :new
        end
        format.json { render layout: false }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :state, :user_id, attachments_attributes: :file)
  end

end
