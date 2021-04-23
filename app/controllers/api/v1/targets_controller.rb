module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def create
        @target = current_user.targets.create! targets_params
      end

      def index
        @targets = current_user.targets.all
      end

      private

      def targets_params
        params.require(:target).permit(:title, :latitude, :longitude, :radius, :topic_id)
      end
    end
  end
end
