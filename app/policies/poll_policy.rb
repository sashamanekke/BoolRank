class PollPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def index?
    return true
  end
  def new?
    return true
  end
  def create?
    return true
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
