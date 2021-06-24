module Api
  module V1
    class AboutController < Api::V1::ApiController
      skip_before_action :authenticate_user!

      def index
        @about = About.last
      end
    end
  end
end
