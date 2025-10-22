module Api
  module V1
    class GreetingsController < BaseController
      def show
        render json: {
          message: "Hello from Odev API",
          requirements: "Built with 5 interconnected models as requested by the assignment."
        }
      end
    end
  end
end
