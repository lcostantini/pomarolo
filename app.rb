require 'cuba'
require 'cuba/render'
require 'slim'
require 'ohm'
require 'pry'

Dir["./models/**/*.rb"].each { |rb| require rb }
Dir["./lib/**/*.rb"].each { |rb| require rb }
Dir["./helpers/**/*.rb"].each { |rb| require rb }

Cuba.use Rack::Static, root: "public", urls: ["/js"]
Cuba.plugin UserHelpers
Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "slim"

Cuba.define do
  on "user" do
    if current_user
      pomodoro = Pomodoro.new({ user: current_user })
      render("add_pomodoro", pomodoro: pomodoro)
      on param("pomodoro") do |params|
        pomodoro = Pomodoro.create(params)
        res.redirect user_path
      end
      res.write partial("home", pomodoros: Pomodoro.find(user: current_user, created_at: Date.today.to_s))
    else
      res.redirect root_path
    end
  end
  
  on "pomarolo/finish/:pomodoro_id" do |pomodoro_id|
    if current_user
      pomodoro = Pomodoro[pomodoro_id].swap_finish
      res.redirect user_path
    else
      res.redirect root_path
    end
  end

  on "pomarolo/interruption/:pomodoro_id" do |pomodoro_id|
    if current_user
      interruption = Interruption.new({ user: current_user, pomodoro: pomodoro_id })
      render("add_interruption", interruption: interruption)
      on param("interruption") do |params|
        interruption = Interruption.create(params)
        res.redirect user_path
      end
      res.write partial("interruptions", interruptions: Interruption.find(user: current_user, pomodoro: pomodoro_id ))
    else
      res.redirect root_path
    end
  end

  on "pomarolo/:pomodoro_id/real/:value" do |pomodoro_id, value|
    if current_user
      pomodoro = Pomodoro[pomodoro_id]
      pomodoro.real_po(value)
      res.write partial("home", pomodoros: Pomodoro.find(user: current_user, created_at: Date.today.to_s))
    else
      res.redirect root_path
    end
  end

  on default do
    run Authentication
  end

end
