class Dashboard::AttachmentsController < Dashboard::DashboardController
  def destroy
    Task.find(params[:task_id]).attachments.find(params[:id]).destroy
    redirect_to dashboard_task_path(params[:task_id])
  end
end
