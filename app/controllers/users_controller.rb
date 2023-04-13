class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


def index
    @users = User.all
    render json: @users
end

private

    def user_params
      params.permit(:name, :email, :password, :age, :balance)
    end

    def render_not_found_response
        render json: { error: "Bettor not found" }, status: :not_found
      end

      def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
