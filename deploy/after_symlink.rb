#-- encoding: UTF-8
# if config.node[:instance_role] == 'solo' ||
#   (config.node[:instance_role] == 'util' && config.current_name =~ /resque/i)
#   worker_count = `ls -l /data/#{config.app}/shared/config/resque_*.conf | wc -l`.to_i
#   warn("Resque Check found #{worker_count} configs to restart on server #{config.current_name}:")
#   # worker_count.times do |count|
#   #   warn("Restarting resque_#{config.app}_#{count}")
#   #   sudo! "monit restart resque_#{config.app}_#{count}"
#   # end
# end
