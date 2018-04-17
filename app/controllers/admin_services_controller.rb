class AdminServicesController < ApplicationController
	before_action :authenticate_admin
	before_action :set_user, only: %i[change_user_status make_admin]

	def index
		@users = User.where(user_type: USER_TYPE_GENERAL).all
		return render_success_list_all_users
	end

	def change_user_status
		@auth = @user.auth
		if @auth.status == AUTH_STATUS_BLOCKED
			if @auth.update(status: AUTH_STATUS_ACTIVE)
				return render_success_user_show
			else
				return render_failure_auth_status
			end	
		elsif @auth.status == AUTH_STATUS_ACTIVE
			if @auth.update(status: AUTH_STATUS_BLOCKED)
				return render_success_user_show
			else
				return render_failure_auth_status
			end	
		end
	end

	def make_admin
		if @user.update(user_type: USER_TYPE_ADMIN)
			return render_success_user_show
		else
			return render_error_user_not_updated
		end
	end

	protected

	def render_success_list_all_users
		render status: :ok, template: "users/index"
	end

	def render_success_user_show
		render status: :ok, template: "users/show"
	end

	def render_failure_auth_status
		render status: :unprocessable_entity, json: {errors: @auth.errors.full_messages}
	end	

	def render_error_user_not_updated
		render status: :unprocessable_entity, json: {errors: @user.errors.full_messages}
	end


	private

	def set_user
		@user = User.find(params[:id])
	end
end
