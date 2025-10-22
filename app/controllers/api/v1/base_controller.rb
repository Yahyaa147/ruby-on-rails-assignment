module Api
  module V1
    class BaseController < ApplicationController
      before_action :ensure_json_request

      private

      def ensure_json_request
        request.format = :json
      end
    end
  end
end
