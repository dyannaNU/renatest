set :output, "#{path}/log/cron.log"

every :hour, at: 0 do
  rake "notifications:send_reminder"
end
