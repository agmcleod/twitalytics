namespace :deploy do
  task :knob do
    ENV["exclude"] = "puppet,.box,.war,.sqlite3"
    Rake::Task["torquebox:remote:stage"].invoke
    Rake::Task["torquebox:remote:exec"].invoke("bundle exec rake db:migrate")
    puts "Migrations Complete..."
  end
end