# config/schedule.rb

set :cron_log, "/var/rails/navigator/cron_log.log"

every 1.day do
  runner "CleaningItem.decrease"
end

every 2.hours do
  rake "thinking_sphinx:index"
end

every :reboot do
  rake "thinking_sphinx:configure"
  rake "thinking_sphinx:rebuild"
end

