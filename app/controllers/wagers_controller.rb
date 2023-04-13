class WagersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    skip_before_action :authorize, only: [:create, :index]

    def index
        wagers = Wager.all
        render json: wagers
    end

    private

    def bet_params
        params.permit(:bet, :user_id, :game_id)
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
