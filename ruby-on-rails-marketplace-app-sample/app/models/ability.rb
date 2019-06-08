# See the wiki for details:
# https://github.com/ryanb/cancan/wiki/Defining-Abilities

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user && user.is_admin?
      can :manage, :all
      can :view, :all
			can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard
    else
      can :read, :all
    end

		can :manage, Listing, :user_id => user.id
  end
end
