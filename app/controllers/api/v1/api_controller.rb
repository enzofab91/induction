module Api
  module V1
    class ApiController < ApplicationController
      include Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!
    end
  end
end
