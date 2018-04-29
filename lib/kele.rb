require_relative 'roadmap'
require_relative 'messages'
require 'httparty'
require 'json'

class Kele
  include HTTParty
  include JSON
  include Roadmap
  include Messages

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post( '/sessions',
      body: { "email": email,
              "password": password
            })
    if response.code != 200
      raise 'invalid email or password'
    end

    @auth_token = response['auth_token']
    @user_email = response['user']['email']
  end

  def get_me
    response = self.class.get('/users/me',
      headers: { "authorization" => @auth_token }
    )
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability",
      body: { "id" => mentor_id },
      headers: { "authorization" => @auth_token }
    )
    JSON.parse(response.body)
  end

  def get_remaining_checkpoints(chain_id)
    response = self.class.get("/enrollment_chains/#{chain_id}/checkpoints_remaining_in_section",
      headers: { "authorization" => @auth_token }
    )
    JSON.parse(response.body)
  end
end
