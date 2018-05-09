class ApplicationController < ActionController::API
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized # using Pundit gem

  def authenticate_user
    if request.headers['sid'].present? and request.headers['stoken'].present?
      session = Session.find_by(id: request.headers['sid'].to_i, stoken: request.headers['stoken'].to_s, sign_in_status: true)
      if !session.nil?
        if session.user.auth.status == AUTH_STATUS_BLOCKED # checking for the blocked status
          return render_error_user_blocked
        end
        @current_user = session.user
        @current_session = session
        # @current_session.update(last_request_at: Time.now)
        # if @current_session.last_request_at < 2.weeks.ago
          
        # end
      else
        return render_error_invalid_tokens
      end
    else
      return render_error_unauthorized
    end
  end

  def authenticate_admin
    if request.headers['sid'].present? and request.headers['stoken'].present?
      session = Session.find_by(id: request.headers['sid'].to_i, stoken: request.headers['stoken'].to_s, sign_in_status: true)
      if !session.nil?
        @current_user = session.user
        @current_session = session
        unless @current_user.user_type == USER_TYPE_ADMIN
          return render_error_admin_access_only
        end
        # @current_session.update(last_request_at: Time.now)
        # if @current_session.last_request_at < 2.weeks.ago
          
        # end
      else
        return render_error_invalid_tokens
      end
    else
      return render_error_unauthorized
    end
  end

  protected

  def user_not_authorized # using Pundit gem
    # policy_name = exception.policy.class.to_s.underscore
    render status: :forbidden, json: {errors: ["unauthorized"]}#"#{policy_name}.#{exception.query}", scope: "pundit", default: :default
  end

  def pundit_user # using Pundit gem
    @current_user
  end

  private

  def render_error_admin_access_only
    render status: :forbidden, json: {errors: ["Only admin are authorized for this reuqest."]}
  end

  def render_error_unauthorized
    render status: :unauthorized, json: {errors: ["You are not authorized for this request."]}
  end

  def render_error_invalid_tokens
    render status: :bad_request, json: {errors: ["Provided tokens were invalid."]}
  end

  def render_error_user_blocked
    render status: :unauthorized, json: {errors: ["You have been blocked by admin."]}
  end
end
