require './common.rb'

Bundler.require :heimdallr

module UserAbility
  extend ActiveSupport::Concern

  included do
    include Heimdallr::Model

    restrict do |user, record|
      user ||= User.new

      scope :fetch, -> { where('users.id > 10') }

      if record
        can    :view
        cannot :view, [:id] unless record.id == user.id
        can    :update  if record.id == user.id
      end
    end
  end
end

class User
  include UserAbility
end

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

puts user.inspect
