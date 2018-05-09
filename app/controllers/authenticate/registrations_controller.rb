module Authenticate 
  #Auth::RegistrationsController < ApplicationController #for namespace in routes 
  class RegistrationsController < ApplicationController

    before_action :authenticate_user, only: [:destroy]

    def create
      @user = User.new(user_params)
      if @user.save
        @auth = @user.build_auth(auth_params)
        if @auth.save
          @session = @user.sessions.build
          if @session.save
            return render_success_user_created
          else
            return render_error_session_not_saved
          end
        else
          @user.destroy
          return render_error_auth_not_saved
        end
      else
        return render_error_user_not_saved
      end
    end

    def destroy
      @current_user.destroy
    end

    protected

    def render_success_user_created
      render status: :created, template: "users/sign_in"
    end

    def render_error_user_not_saved
      render status: :unprocessable_entity, json: {errors: @user.errors.full_messages}
    end

    def render_error_auth_not_saved
      render status: :unprocessable_entity, json: {errors: @auth.errors.full_messages}
    end

    def render_error_session_not_saved
      render status: :unprocessable_entity, json: {errors: @session.errors.full_messages}
    end

    private

    def user_params
      params.permit(:name, :email, :username)
    end

    def auth_params
      params.permit(:password, :password_confirmation)
    end
  end
end