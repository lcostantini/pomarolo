require "cuba"
require "mote"
require "mote/render"
require "ohm"
require_relative "./lib/authentication/authentication"

Cuba.plugin Mote::Render
Cuba.plugin Mote::Helpers

Dir["./models/**/*.rb"].each { |rb| require rb }

Cuba.define do
  on root do
    run Authentication
  end
  
  on "logout" do
    run Authentication
  end
  
  on "signup" do
    run Authentication
  end
  
  on "login" do
    run Authentication
  end
  
  on "user" do
    edit = Pomodoro.new({})
    render("add_pomodoro", edit: edit, title: "Pomarolos")
    on param("pomodoro") do |params|
      pomodoro = Pomodoro.create(params)
      res.redirect "/user"
    end
    res.write mote("views/layout.mote",
      title: "Pomarolos",
      content: mote("views/home.mote", pomodoros: Pomodoro.all ))
  end

  on "pomarolo/:pomodoro_id" do |pomodoro_id|
    pomodoro = Pomodoro[pomodoro_id].swap_finish
    res.redirect "/user"
  end 
end
