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
    if session[:user].nil?
      res.redirect "/"
    else
      pomarolo = Pomodoro.new({ user: session[:user] })
      render("add_pomodoro", pomarolo: pomarolo, title: "Pomarolos")
      on param("pomodoro") do |params|
        pomodoro = Pomodoro.create(params)
        res.redirect "/user"
      end
      res.write partial("home", pomodoros: Pomodoro.find(:user => session[:user]))
    end
  end
  
  on "pomarolo/finish/:pomodoro_id" do |pomodoro_id|
    pomodoro = Pomodoro[pomodoro_id].swap :finish
    res.redirect "/user"
  end

  on "pomarolo/interruption/:pomodoro_id" do |pomodoro_id|
    pomodoro = Pomodoro[pomodoro_id].swap :interruption
    res.redirect "/user"
  end

  on default do
    run Authentication
  end
end
