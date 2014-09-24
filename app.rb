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
      pomodoro = Pomodoro.new({ user: session[:user] })
      render("add_pomodoro", pomodoro: pomodoro, title: "Pomarolos")
      on param("pomodoro") do |params|
        pomodoro = Pomodoro.create(params)
        res.redirect "/user"
      end
      res.write partial("home", pomodoros: Pomodoro.find(:user => session[:user]))
    end
  end
  
  on "pomarolo/finish/:pomodoro_id" do |pomodoro_id|
    pomodoro = Pomodoro[pomodoro_id].swap_finish
    res.redirect "/user"
  end

  on "pomarolo/interruption/:pomodoro_id" do |pomodoro_id|
    interruption = Interruption.new({ user: session[:user], pomodoro: pomodoro_id })
    render("add_interruption", interruption: interruption, title: "Pomarolos")
    on param("interruption") do |params|
      interruption = Interruption.create(params)
      res.redirect "/user"
    end
    res.write partial("interruptions", interruptions: Interruption.find(:user => session[:user], :pomodoro => pomodoro_id ))
  end

  on default do
    run Authentication
  end
end
