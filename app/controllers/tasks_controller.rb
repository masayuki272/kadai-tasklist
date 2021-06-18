class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index]
  before_action :correct_user, only: [:show, :destroy, :edit]

  def index
    @tasks = Task.all
  end

  def show
#    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
      @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = 'Taskが正常に登録されました'
        redirect_to root_url
      else
        flash.now[:danger] = 'Taskが登録されませんでした'
        render :new
      end
  end

  def edit
#      @task = Task.find(params[:id])
  end

  def update
      @task = Task.find(params[:id])

      if @task.update(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Task は更新されませんでした'
        render :edit
      end

  end

  def destroy
 #     @task = Task.find(params[:id])
      @task.destroy
      flash[:success] = 'Task は正常に削除されました'
      redirect_to tasks_url
  end

  private
  
  def task_params
      params.require(:task).permit(:status, :content)
  end


  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end


end