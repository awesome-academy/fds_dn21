class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    cannot :read, Order
    if user.present?
      can :manage, Order, user_id: user.id
      can :manage, Rate
      if user.admin?
        can :manage, :all
        cannot :create, Order
      end
    end
  end
end
