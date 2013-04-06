require './common.rb'
require './heimdallr.rb'

# read
puts 'Read: ' + User.restrict(@current_user).pluck(:name).join(', ')

# update
user = User.restrict(@current_user).find_by_id(42)
begin
  user.update_attributes!(name: '42th User')
rescue => e
  puts "Boom! #{e}"
end
puts 'Write: ' + user.name
puts 'Write again: ' + User.find(42).name

puts (user.implicit.id || '#FILTERED')

puts "How proxy object looks like:"
puts user.inspect
