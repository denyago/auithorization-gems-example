require './common.rb'

Bundler.require :resourced

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new

    can :read, User,    'users.id > 10'
    can :edit, User,    id: user.id
    can :see_id, User,  id: user.id
  end
end

current_ability = Ability.new(@current_user)

# read
puts 'Read: ' + User.accessible_by(current_ability).pluck(:name).join(', ')

# update
user = User.accessible_by(current_ability).find_by_id(42)
user.update_attributes(name: '42th User') if current_ability.can? :edit, user
puts 'Write: ' + user.name

puts (current_ability.can?(:see_id, user) ? user.id : '#FILTERED')
