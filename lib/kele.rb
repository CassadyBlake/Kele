require 'httparty'
require 'json'

class Kele
  include HTTParty
  include JSON
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
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

end
