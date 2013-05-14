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
