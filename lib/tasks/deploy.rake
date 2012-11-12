namespace :deploy do
  task :knob do
    ENV["exclude"] = "puppet,.box,.war,.sqlite3"
    Rake::Task["torquebox:archive"].invoke
    Rake::Task["torquebox:remote:stage"].invoke
    Rake::Task["torquebox:remote:bash"].invoke("chmod +x vendor/bundle/jruby/1.9/*")
    Rake::Task["torquebox:remote:exec"].invoke("bundle exec rake db:migrate")
    puts "Migrations Complete..."
    Rake::Task["torquebox:remote:stage:deploy"].invoke
    puts "Deployment Complete!"
  end
end