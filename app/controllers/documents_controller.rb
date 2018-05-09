class DocumentsController < ApplicationController

  before_action :find_document, only: [:show, :destroy]
  before_action :authenticate_user, only: [:create,:destroy]

  def create
    @document = @current_user.documents.build(doc_params)
    if @document.save
    	render status: :ok , template: "documents/show"
    else
    	render status: :unprocessable_entity , json: {errors: @document.errors.full_messages }	
    end
  end

  def show
  	
  end

  def destroy
    if @current_user == @document.user
  	 @document.destroy
    else
     return render_error_unauthorized_user
    end
  end

  private

  def render_error_unauthorized_user
    render status: :unauthorize , json: {errors: "unauthorize User"} 
  end


  def doc_params
    params.permit(:input)
  end

  def find_document
    @document = Document.find(params[:id])
  end
#
#1 MODEL
#2 Application Controller for recieving the URL of the image
#3 4 fixed attributes are required
end
