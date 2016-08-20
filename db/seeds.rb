# Seed an Admin user with password - Admin
#
user = User.create :first_name => "Admin", :last_name => "Admin", :username => "admin", :password => "admin", :email => "admin@example.com", :role => "admin"

ratsetting = Setting.create :name => "tick_types", :description => "This is where we define which Ticks we want to record in the user section of RaTs. These will also be displayed in the per-team graphs", :enabled => "0"

ticksetting = Setting.create :name => "rat_types", :description => "This is where we define which Rats we want to record in the user section of RaTs. These will also be displayed in the pre-team graphs", :enabled => "0"


