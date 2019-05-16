class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :update, Category
    if user.present?
      can :manage, Order, user_id: user.id
      can :manage, Rate
      if user.admin?
        can :manage, :all
      end
    end
  end
end
