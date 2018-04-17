json.extract! user,  :name, :email, :username

if user.auth.status == AUTH_STATUS_BLOCKED
	json.auth_status_blocked true
elsif	user.auth.status == AUTH_STATUS_ACTIVE
	json.auth_status_blocked false
end

if user.user_type == USER_TYPE_GENERAL
	json.user_admin false

elsif user.user_type == USER_TYPE_ADMIN
	json.user_admin true
end
