module Authentication

class SessionsController < ApplicationController
  before_action :authenticate_user, only: [:destroy]

  def create
 if params[:password].present? and params[:username].present?
     @user = User.find_by(username: params[:username].to_s)
     if !@user.nil?
       @auth = @user.auth
         if @auth.authenticate(params[:password])
           @session = @user.sessions.build
           if @session.save
            return render_success_user_created #added myself
           else 
             return render_error_session_not_saved
           end
         else
         return render_error_password_mismatch
         end
     else
      return render_error_user_not_found
     end
   else
     return render_error_invalid_params
   end
   end

  def destroy
    @current_session.update(sign_in_status: false)
  end


  protected


  def render_success_user_created
    render status: :created, template: "users/sign_in"
  end

  def render_error_password_mismatch
  render status: :unprocessable_entity, json: {errors: @user.errors.full_messages}
  end

  def render_error_user_not_found
  render status: :unprocessable_entity, json: {errors: "Username not found"}
  end

  def render_error_invalid_params
  render status: :unprocessable_entity, json: {errors: "Invalid params"}
  end

  def render_error_session_not_save
    render status: :unprocessable_entity, json: {errors: @session.errors.full_messages}
  end


end

end