require "cuba"
require "mote"
require "mote/render"
require "ohm"
require 'pry'

Cuba.plugin Mote::Render
Cuba.plugin Mote::Helpers

Dir["./models/**/*.rb"].each { |rb| require rb }
Dir["./lib/**/*.rb"].each { |rb| require rb }

Cuba.define do
  on "user" do
    pomarolo = Pomodoro.new({ user_id: session[:user] })
    render("add_pomodoro", pomarolo: pomarolo, title: "Pomarolos", logged: session[:user])
    on param("pomodoro") do |params|
      pomodoro = Pomodoro.create(params)
      res.redirect "/user"
    end

    res.write mote("views/layout.mote",
      title: "Pomarolos",
      logged: session[:user],
      content: mote("views/home.mote", pomodoros: Pomodoro.find(:user_id => session[:user])))
  end
  
  on "pomarolo/finish/:pomodoro_id" do |pomodoro_id|
    pomodoro = Pomodoro[pomodoro_id].swap_finish
    res.redirect "/user"
  end

  on "pomarolo/interruption/:pomodoro_id" do |pomodoro_id|
    pomodoro = Pomodoro[pomodoro_id].swap_interruption
    res.redirect "/user"
  end

  on default do
    run Authentication
  end
end
