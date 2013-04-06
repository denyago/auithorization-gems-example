require './common.rb'
require './cancan.rb'

# read
puts 'Read: ' + User.accessible_by(@current_ability).pluck(:name).join(', ')

# update
user = User.accessible_by(@current_ability).find_by_id(42)
user.update_attributes(name: '42th User') if @current_ability.can? :edit, user
puts 'Write: ' + user.name

puts (@current_ability.can?(:see_id, user) ? user.id : '#FILTERED')
