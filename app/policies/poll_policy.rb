class PollPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    #if record.public == true || (record.user == user || record.participants.include?(user))
    return true
  end

  def new?
    return true
  end

  def create?
    # Any logged in user can create a poll ->
    return true
  end

  def update?
    # only poll owners can update it
    record.user == user
  end

  def destroy?
    update?
  end

  def add_propositions?
    return true
  end
  def edit? #actually not necessary because yet we don't let the user edit its form
    # user => current_user
    # record => current.record
    if record.user == user
      return true
    else
      return false
    end
  end
  def start?
    #if record.user == user || record.participants.include?(user)
      return true
    #else
    # return false
    #end
  end
  def compare?
    if record.user == user || record.participants.include?(user)
      return true
    else
     return false
    end
  end
  def results?
    if record.user == user || record.participants.include?(user)
      return true
    else
     return false
    end
  end
end
