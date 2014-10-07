require "cuba"
require "mote"
require "rack/protection"
require "ohm"

Cuba.plugin Mote::Helpers

Cuba.use Rack::MethodOverride
Cuba.use Rack::Session::Cookie,
  key: "pomarolos",
  secret: "your_secret_here"

Cuba.use Rack::Protection
Cuba.use Rack::Protection::RemoteReferrer

Dir["./lib/authentication/models/**/*.rb"].each  { |rb| require rb }

class Authentication < Cuba
  define do
    on root do
      res.write mote("lib/authentication/views/layout.mote",
        user_id: session[:user],
        content: mote("lib/authentication/views/home.mote"))
    end
    
    on "signup" do
      res.write mote("lib/authentication/views/signup.mote", user: User.new)
      on param("user") do |params|
        User.create(params)
        res.redirect ("/user")
      end
    end
    
    on "login" do
      res.write mote("lib/authentication/views/login.mote", user: User.new)
      on param("user") do |params|
        user = User.with(:email, params["email"]) unless nil
        if user && user.password == params["password"]
          session[:user] = user.id
          res.redirect ("/user")
        else
          res.write mote("lib/authentication/views/layout.mote",
            message: "Email or password are incorrect.",
            content: mote("lib/authentication/views/login.mote", params: params))
        end
      end
    end

    on "logout" do
      session.delete(:user)
      res.redirect ("/user")
    end
  end
end
