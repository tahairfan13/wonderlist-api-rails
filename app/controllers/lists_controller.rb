class ListsController < ApplicationController
  before_action :find_params, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:create,:update,:destroy,:index,:show]

  def index
    if params[:page].present? and params[:timestamp].present?
      @lists = @current_user.lists.order('id DESC').where('lists.created_at <= ?', params[:timestamp].to_datetime).page(params[:page].to_i)
      @timestamp = params[:timestamp].to_datetime
    else
      @lists = @current_user.lists.order('id DESC').page(1)
      @timestamp = Time.zone.now
    end
  end

  def show
  end

  def create
    @list = @current_user.lists.build(list_params)
      if @list.save
        render status: :created ,template: 'lists/show'
      else
        render status: :unprocessable_entity , json: {errors: @list.errors.full_messages }
      end
  end

  def update
    authorize @list
    if @list.update(list_params)
      render status: :ok ,template: 'lists/show'
    else
      render status: :unprocessable_entity , json: {errors: @list.errors.full_messages }
    end
  end

  def destroy
    authorize @list #use of pundit gem ...it helps in authorization
    @list.destroy
  end

  private

  def list_params
    params.permit(:name)
  end

  def find_params
    @list = List.find(params[:id])
  end


end
