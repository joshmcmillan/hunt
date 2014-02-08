class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    can :manage, Hunt, Hunt.all do |hunt|
      hunt.users.include?(user)
    end

    can :manage, Property, Property.all do |property|
      property.hunt.users.include?(user)
    end

    can :manage, Location
    # can :manage, Property, 
  end
end
