class TasksController < ApplicationController

  before_action :find_list
  before_action :find_task, only: %i[show update destroy]
  before_action :authenticate_user, only: [:create,:update,:destroy,:index,:show]

  def index
    if @current_user == @list.user
      @tasks = @list.tasks
    else  
      return render_error_unauthroized
    end
  end

  def create
    @task = @list.tasks.build(task_params)
    authorize @task
    if @task.save
      return render_success_task_created
    else
      return render_error_task_not_saved
    end
  end

  def show
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      return render_success_task_show
    else
      return render_error_task_not_saved
    end
  end

  def destroy
    authorize @task
    @task.destroy
  end

  protected

  def render_success_task_created
    render status: :created, template: "tasks/show"
  end

  def render_success_task_show
    render status: :ok, template: "tasks/show"
  end

  def render_error_task_not_saved
    render status: :unprocessable_entity, json: {errors: @task.errors.full_messages }
  end

  private

  def task_params
    params.permit(:name)
  end

  def find_list
    @list = List.find(params[:list_id])
  end

  def find_task
    @task = @list.tasks.find(params[:id])
  end


end

