require "rubygems"
require "rspec"
require "watir-webdriver"
require "test/unit"
require "watir-ng"

WatirNg.patch!

include Test::Unit::Assertions

hostname = "127.0.0.1:8080"

describe "Login and Install" do
  before(:all) do
    @browser = Watir::Browser.new :firefox
    @browser.goto "http://#{hostname}"
  end


  it "Login" do
    @browser.h3(:text => "Login to RaTS").wait_until_present
    @browser.text_field(:name => "username").set "admin"
    @browser.text_field(:name => "password").set "admin"
    @browser.button(:value => "Log In").click
    @browser.h3(:text => "Resource and Timekeeping System").wait_until_present
  end

# Setup Teams

  it "Setup Team Carrot" do
    @browser.link(:text => "Teams").click
    @browser.button(:value => "New Team").wait_until_present
    @browser.button(:value => "New Team").click
    @browser.text_field(:id => "inputTeamName").set "Captain Carrot Ironfoundersson"
    @browser.text_field(:id => "inputTeamDescription").set "Hair to the throne of Ankh-Morpork, but happy being a watchman"
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "Team: Captain Carrot Ironfoundersson").wait_until_present
  end

  it "Setup Team Vimes" do
    @browser.link(:text => "Teams").click
    @browser.button(:value => "New Team").wait_until_present
    @browser.button(:value => "New Team").click
    @browser.text_field(:id => "inputTeamName").set "Commander Samuel Vimes"
    @browser.text_field(:id => "inputTeamDescription").set "Drunk watchman to a Duke."
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "Team: Commander Samuel Vimes").wait_until_present
  end

# Setup some users in Carrot's team

  it "Add's Captain Carrot" do
    @browser.link(:text => "Agents").click
    @browser.button(:value => "New User").wait_until_present
    @browser.button(:value => "New User").click
    @browser.text_field(:id => "inputFirstName").set "Carrot"
    @browser.text_field(:id => "inputLastName").set "Ironfoundersson"
    @browser.text_field(:id => "inputCustomID").set "12345"
    @browser.select_list(:id => "inputTeamNameModel").select "Captain Carrot Ironfoundersson"
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "User: Carrot Ironfoundersson").wait_until_present
  end

  it "Add's Captain Angua" do
    @browser.link(:text => "Agents").click
    @browser.button(:value => "New User").wait_until_present
    @browser.button(:value => "New User").click
    @browser.text_field(:id => "inputFirstName").set "Angua"
    @browser.text_field(:id => "inputLastName").set "von Uberwald"
    @browser.text_field(:id => "inputCustomID").set "23789"
    @browser.select_list(:id => "inputTeamNameModel").select "Captain Carrot Ironfoundersson"
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "User: Angua von Uberwald").wait_until_present
  end

  it "Add's Detritus" do
    @browser.link(:text => "Agents").click
    @browser.button(:value => "New User").wait_until_present
    @browser.button(:value => "New User").click
    @browser.text_field(:id => "inputFirstName").set "Sergeant"
    @browser.text_field(:id => "inputLastName").set "Detritus"
    @browser.text_field(:id => "inputCustomID").set "75395"
    @browser.select_list(:id => "inputTeamNameModel").select "Captain Carrot Ironfoundersson"
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "User: Sergeant Detritus").wait_until_present
  end

# Setup some users for Vimes' team

  it "Add's Samuel Vimes" do
    @browser.link(:text => "Agents").click
    @browser.button(:value => "New User").wait_until_present
    @browser.button(:value => "New User").click
    @browser.text_field(:id => "inputFirstName").set "Samuel"
    @browser.text_field(:id => "inputLastName").set "Vimes"
    @browser.text_field(:id => "inputCustomID").set "177"
    @browser.select_list(:id => "inputTeamNameModel").select "Commander Samuel Vimes"
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "User: Samuel Vimes").wait_until_present
  end

  it "Add's Fred Colon" do
    @browser.link(:text => "Agents").click
    @browser.button(:value => "New User").wait_until_present
    @browser.button(:value => "New User").click
    @browser.text_field(:id => "inputFirstName").set "Fred"
    @browser.text_field(:id => "inputLastName").set "Colon"
    @browser.text_field(:id => "inputCustomID").set "149"
    @browser.select_list(:id => "inputTeamNameModel").select "Commander Samuel Vimes"
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "User: Fred Colon").wait_until_present
  end

  it "Add's Nobby Nobbs" do
    @browser.link(:text => "Agents").click
    @browser.button(:value => "New User").wait_until_present
    @browser.button(:value => "New User").click
    @browser.text_field(:id => "inputFirstName").set "Nobby"
    @browser.text_field(:id => "inputLastName").set "Nobbs"
    @browser.text_field(:id => "inputCustomID").set "569"
    @browser.select_list(:id => "inputTeamNameModel").select "Commander Samuel Vimes"
    @browser.button(:value => "Submit").click
    @browser.h3(:text => "User: Nobby Nobbs").wait_until_present
  end

# Now set up Rats and Ticks in Settings

  it "Enable's Rats and Ticks" do
    @browser.link(:text => "Admin").click
    @browser.link(:text => "Settings").click
    @browser.button(:class => 'class="btn btn-default dropdown-toggle"', :index => 0).click
    @browser.link(:text => "Edit").click
    @browser.checkbox(:id => "setting_enabled").set
    @browser.button(:value => "Submit").click
    @browser.link(:text => "Admin").click
    @browser.link(:text => "Settings").click
    @browser.xpath(:value => "//div[2]/div/div[3]/div/button").click
    @browser.checkbox(:id => "setting_enabled").set
    @browser.button(:value => "Submit").click
  end

  it "Add's Rat - too much paperwork" do
    @browser.li(:class => "dropdown").click
    @browser.li(:text => "Settings").click
    @browser.link(:href => "/settings/2/edit").wait_until_present
    @browser.link(:href => "/settings/2").click
    @browser.button(:value => "New rat_types").click
    @browser.text_field(:id => "name").set "Too much Paperwork"
    @browser.text_field(:id => "description").set "Officer created too much paperwork for Vimes"
    @browser.button(:value => "Submit").click
    @browser.td(:text => "Too much Paperwork").wait_until_present
  end

  it "Add's Rat - Dishonest" do
    @browser.li(:class => "dropdown").click
    @browser.li(:text => "Settings").click
    @browser.link(:href => "/settings/2/edit").wait_until_present
    @browser.link(:href => "/settings/2").click
    @browser.button(:value => "New rat_types").click
    @browser.text_field(:id => "name").set "Dishonest"
    @browser.text_field(:id => "description").set "Officer found to be dishonest (not Nobby Nobbs)"
    @browser.button(:value => "Submit").click
    @browser.td(:text => "Dishonest").wait_until_present
  end

  it "Add's Tick - Armour dents" do
    @browser.li(:class => "dropdown").click
    @browser.li(:text => "Settings").click
    @browser.link(:href => "/settings/1/edit").wait_until_present
    @browser.link(:href => "/settings/1").click
    @browser.button(:value => "New tick_types").click
    @browser.text_field(:id => "name").set "Armour Dents"
    @browser.text_field(:id => "description").set "Officer returned from shift with fresh dents in their armour"
    @browser.button(:value => "Submit").click
    @browser.td(:text => "Armour Dents").wait_until_present
  end

  it "Add's Rat - Dishonest" do
    @browser.li(:class => "dropdown").click
    @browser.li(:text => "Settings").click
    @browser.link(:href => "/settings/1/edit").wait_until_present
    @browser.link(:href => "/settings/1").click
    @browser.button(:value => "New tick_types").click
    @browser.text_field(:id => "name").set "Arrested Assasin"
    @browser.text_field(:id => "description").set "Officer arrested an assasin for loitering or any other offence"
    @browser.button(:value => "Submit").click
    @browser.td(:text => "Arrested Assasin").wait_until_present
  end

  after(:all) do
    @browser.close
  end

end
