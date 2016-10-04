# Seed an Admin user with password - Admin
#
puts "Creating Admin User"
admin = User.create :first_name => "Admin", :last_name => "Admin", :username => "admin", :password => "admin", :password_confirmation => "admin", :email => "admin@example.com", :role => "admin"
puts "Creating Junior Admin User"
junior_admin = User.create :first_name => "Junior", :last_name => "Admin", :username => "junioradmin", :password => "password", :password_confirmation => "password", :email => "junioradmin@example.com", :role => "junior_admin"
puts "Creating Team Leader User"
team_leader = User.create :first_name => "Team", :last_name => "Leader", :username => "teamleader", :password => "password", :password_confirmation => "password", :email => "teamleader@example.com", :role => "team_leader"
puts "Creating Supervisor User"
supervisor = User.create :first_name => "Supervisor", :last_name => "Agent", :username => "supervisor", :password => "password", :password_confirmation => "password", :email => "supervisor@example.com", :role => "supervisor"
puts "Creating Agent User"
agent = User.create :first_name => "Agent", :last_name => "Agent", :username => "agent", :password => "password", :password_confirmation => "password", :email => "agent@example.com", :role => "user"

puts "Create Rat Setting"
crosssetting = Setting.create :name => "tick_types", :description => "This is where we define which Ticks we want to record in the user section of RaTs. These will also be displayed in the per-team graphs", :enabled => "0"
puts "Create Tick Setting"
ticksetting = Setting.create :name => "cross_types", :description => "This is where we define which Rats we want to record in the user section of RaTs. These will also be displayed in the pre-team graphs", :enabled => "0"
puts "Creating Broadcast setting"
broadcast = Setting.create :name => "broadcast_settings", :description => "This defines if the broadcasts section of crosses is enabled and what sections generate a broadcast message to all users.", :enabled => "0"
puts "Creating QA setting"
qa_setting = Setting.create :name => "qa_settings", :description => "This is where the QA options are configured per team. If it is a generic QA, then leave the team field blank.", :enabled => "0"
puts "Creating QA General Setting"
qa_general_setting = Setting.create :name => "qa_general_settings", :description => "This is where the general options for QA are stored. There should be changed to suit, but not removed as it will break the overview", :enabled => "1"
puts "Creating standard QA General settings"
qa_general_colours = ["yellow", "green", "red"]
setting = Setting.where(:name => "qa_general_settings").first
qa_general_colours.each do |c|
  puts "  - Creating #{c} for badges"
  QaGeneralSetting.create :name => "year_view_#{c}_badge", :value => "0", :disabled => "1", :setting_id => setting.id
end
