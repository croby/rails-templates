# template style and some of this from http://railscasts.com/episodes/148-app-templates-in-rails-2-3
# thanks for teaching me Rails, Mr. Bates


# app stuff
run "echo TODO > README"

plugin "jrails", :git => "git://github.com/aaronchi/jrails.git"

if yes?("Need attachments?")
  plugin "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"
end

if yes?("Need authentication?")
  plugin "restful-authentication", :git => "git://github.com/technoweenie/restful-authentication.git"
  generate :authenticated, "user", "sessions"
  route "map.signup  '/signup', :controller => 'users',   :action => 'new'"
  route "map.login  '/login',  :controller => 'session', :action => 'new'"
  route "map.logout '/logout', :controller => 'session', :action => 'destroy'"
end

gem "simple_layout"
rake "gems:install"

generate :controller, "home"
route "map.root :controller => 'home'"
git :rm => "public/index.html"

run "cp config/database.yml config/example_database.yml"

# git stuff
git :init

file ".gitignore", <<-END
.DS_Store
log/*.log
temp/**/*
config/database.yml
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"

git :add => ".", :commit => "-m 'initial commit'"