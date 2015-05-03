require 'cancan'

module Spree
  class AbilityDecorator
    include CanCan::Ability

    def initialize(user)
      user ||= Spree.user_class.new

      if user.respond_to?(:has_spree_role?) && user.has_spree_role?('admin')
        can :manage, :all
      else
        can [:index, :read], City
      end

    end

  end
end

Spree::Ability.register_ability(Spree::AbilityDecorator)
