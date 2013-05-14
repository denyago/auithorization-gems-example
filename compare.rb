require './common.rb'
require './heimdallr.rb'
require './cancan.rb'

User.destroy_all

5000.times do |i|
  User.create!(id: i, name: 'Name ' + i.to_s)
end

Benchmark.bmbm(3) do |x|
  x.report("CanCan: ")    { User.accessible_by(@current_ability).all }
  x.report("Heimdallr: ") { User.restrict(@current_user).all }
  x.report("Heimdallr (insecure): ") { User.restrict(@current_user).insecure.all }
end
