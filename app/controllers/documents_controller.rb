class DocumentsController < ApplicationController

before_action :find_params, only: [:show,:destroy]
before_action :authenticate_user, only: [:create]

def create
  @doc = @current_user.documents.build(doc_params)
  if @doc.save
  	render status: :ok , json: {success: "Doc successfully created" }
  else
  	render status: :unprocessable_entity , json: {errors: @doc.errors.full_messages }	
  end

end

def show
	
end

def destroy
	@doc.destroy
end

 private

 def doc_params
    params.permit(:input,:documentable_id,:documentable_type)
  end

  def find_params
    @doc = Document.find(params[:id])
  end


#
#1 MODEL
#2 Application Controller for recieving the URL of the image

end
