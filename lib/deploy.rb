puts "Pushing to Heroku......"
system "git push heroku master"

pending_migrations = `heroku run rake db:migrate:status | grep down`
puts pending_migrations

if pending_migrations.length > 0
  puts "Now running pending Rails migrations..."
  system "heroku rake db:migrate"
end

puts "Push complete."
