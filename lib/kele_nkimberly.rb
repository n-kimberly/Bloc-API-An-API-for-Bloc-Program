# https://github.com/jnunemaker/httparty
# https://github.com/flori/json

require 'httparty'
require 'json'

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

    response = self.class.post('/sessions', options)

    @auth_token = response['auth_token']

    raise "Wrong email or password. Try again." if response.code == 404

  end

  def get_me

    response = self.class.get(
      '/users/me', headers: {
        "authorization" => @auth_token
        }
      )

    @current_user = JSON.parse(response.body)

  end

end
