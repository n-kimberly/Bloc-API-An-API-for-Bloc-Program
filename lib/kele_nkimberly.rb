# https://github.com/jnunemaker/httparty
# https://github.com/flori/json

require "httparty"
require "json"

class Kele

  def self.test

    puts "Hello world!"

  end

  include HTTParty

  base_uri "https://www.bloc.io/api/v1"

  def initialize(email, password)

    options = {
      body: {
        email: email,
        password: password
      }
    }

    response = self.class.post("/sessions", options)

    @auth_token = response["auth_token"]

    raise "Wrong email or password. Try again." if response.code == 404

  end

  def get_me

    response = self.class.get(
      "/users/me", headers: {
        "authorization" => @auth_token
        }
      )

    @current_user = JSON.parse(response.body)

  end

  def get_mentor_availability(mentor_id)

    response = self.class.get(
      "/mentors/#{mentor_id}/student_availability", headers: {
        "authorization" => @auth_token
      }
    )

    @mentor_availability = JSON.parse(response.body)

  end

  def get_roadmap(roadmap_id)

    response = self.class.get(
      "/roadmaps/#{roadmap_id}", headers: {
        "authorization" => @auth_token
      }
    )

    @roadmap = JSON.parse(response.body)

  end

  def get_checkpoint(checkpoint_id)

    response = self.class.get(
      "/checkpoints/#{checkpoint_id}", headers: {
        "authorization" => @auth_token
      }
    )

    @checkpoint = JSON.parse(response.body)

  end

end
