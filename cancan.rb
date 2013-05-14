Bundler.require :cancan

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new

    can :read, User,    'users.id > 10'
    can :edit, User,    id: user.id
    can :see_id, User,  id: user.id
  end
end

@current_ability = Ability.new(@current_user)
