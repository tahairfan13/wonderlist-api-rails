class ListsController < ApplicationController
  before_action :find_params, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:create,:update,:destroy,:index,:show]

  def index
    if params[:page].present? and params[:timestamp].present? #for pagination
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
        if params[:document_id].present?
          document = Document.find_by(id: params[:document_id].to_i)
          unless document.nil? 
            if document.user == @current_user
              document.update(documentable: @list)
            else
              return render_error_unauthorized_user
            end
          end
        end
        render status: :created ,template: 'lists/show'
      else
        render status: :unprocessable_entity , json: {errors: @list.errors.full_messages }
      end
  end

  def update
    authorize @list
    if @list.update(list_params)
      if params[:document_id].present?
        document = Document.find_by(id: params[:document_id].to_i)
        unless document.nil?
          if document.user == @current_user
            if !@list.document.nil? and @list.document != document
              document.update(documentable: @list)
            else
              return render_same_document_attached    
            end
          else
            return render_error_unauthorized_user
          end
        end
      end
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

  def render_same_document_attached
    render status: :ok , json: {errors: I18n.t('render.document.same_doc_attached')} 
   #render status: :ok , json: {errors: "Same document attached already"} 
  end

  def render_error_unauthorized_user
   render status: :unauthorize , json: { errors: "unauthorize user"} 
  end

  def list_params
   params.permit(:name)
  end

  def find_params
   @list = List.find(params[:id])
  end


end
