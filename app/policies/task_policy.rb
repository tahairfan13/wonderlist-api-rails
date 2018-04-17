class TaskPolicy < ApplicationPolicy

def create?
 @record.list.user == @user
end	

def update?
	@record.list.user == @user
end

def destroy?
	@record.list.user == @user
end


end
