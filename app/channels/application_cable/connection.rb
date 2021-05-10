module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        get_headers

        if verified_user = User.find_by(email: uid)
          if verified_user.valid_token?(token, client)
        else
          reject_unauthorized_connection
        end
      end

      def get_headers
        uid = request.headers['uid']
        access_token = request.headers['access-token']
        client = request.headers['client']
      end
  end
end
