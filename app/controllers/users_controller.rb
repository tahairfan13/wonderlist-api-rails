class UsersController < ApplicationController
before_action :authenticate_user

def update
	@user = @current_user
	if @user.update(user_params)
	 return render_success_user_updated
	else
	 return render_error_user_updated
	end
end

def page

end



protected

def render_success_user_updated
render status: :ok, template: "users/show"
end

def render_error_user_updated
render status: :unprocessable_entity, json: {errors: @user.errors.full_messages }	
end

private

def user_params
params.permit(:name,:email)
end


end
