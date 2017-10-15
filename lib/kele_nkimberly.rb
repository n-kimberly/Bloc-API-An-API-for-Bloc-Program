# https://johnnunemaker.com/httparty/

require 'httparty'

class Kele

  def self.test

    puts "Hello world!"

  end

  include HTTParty

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)

    options = {
      body: {
        email: email,
        password: password
      }
    }

    signin = self.class.post('/sessions', options)

    @current_user_token = signin['auth_token']

    raise "Wrong email or password. Try again." if signin.code == 404

  end

end
