class FacebookService
  FACEBOOK_OBJECTS = 'me?fields=email,first_name,last_name'.freeze

  def initialize(access_token)
    @access_token = access_token
  end

  def profile
    client.get_object(FACEBOOK_OBJECTS)
  end

  def client
    Koala::Facebook::API.new(@access_token)
  end
end
