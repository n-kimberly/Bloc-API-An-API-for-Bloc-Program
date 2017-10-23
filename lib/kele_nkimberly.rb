# https://github.com/jnunemaker/httparty
# https://github.com/flori/json

require "httparty"
require "json"
require "/home/n-kimberly/bloc/ruby/kele-nkimberly/lib/roadmap.rb"

class Kele

  def self.test

    puts "Hello world!"

  end

  include HTTParty
  include Roadmap

  base_uri "https://www.bloc.io/api/v1"

  def initialize(email, password)

    options = {
      query: {
        "email": email,
        "password": password
      }
    }

    response = self.class.post("/sessions", options)

    @auth_token = response["auth_token"]

    raise "Wrong email or password. Try again." if response.code == 404

    get_me
    @user_email = @current_user["email"]
    @enrollment_id = @current_user["current_enrollment"]["id"]

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


  def get_messages(page = 1)

    response = self.class.get(
      "/message_threads?page=#{page}", headers: {
        "authorization" => @auth_token
      }
    )

    @messages = JSON.parse(response.body)

  end

  def create_message(recipient_id, subject, message)

    options = {
      query: {
        "sender": @user_email,
        "recipient_id": recipient_id,
        "subject": subject,
        "stripped-text": message
      },
      headers: {
        "authorization" => @auth_token
      }
    }

    response = self.class.post("/messages", options)

    puts response

  end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment)

    options = {
      query: {
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "checkpoint_id": checkpoint_id,
        "comment": comment,
        "enrollment_id": @enrollment_id,
      },
      headers: {
        "authorization" => @auth_token
      }
    }

    response = self.class.post("/checkpoint_submissions", options)

    puts response

  end

end
