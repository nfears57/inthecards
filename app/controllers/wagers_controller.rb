class WagersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    skip_before_action :authorize, only: [:create, :index]

    def index
        wagers = Wager.all
        render json: wagers
    end

    def create_wager(game_id, amount, user_id)
        game = Game.find(game_id)
        user = User.find(user_id)
      
        # Check if the user has enough balance to place the wager
        if user.balance < amount
          return "Insufficient balance"
        end
      
        # Create the wager
        wager = Wager.new
        wager.game_id = game_id
        wager.amount = amount
        wager.user_id = user_id
      
        if wager.save
          # Deduct the amount from the user's balance
          user.balance -= amount
          user.save
      
          return "Wager placed successfully"
        else
          return "Error placing wager"
        end
      end
      

    private

    def bet_params
        params.permit(:bet, :user_id, :game_id)
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
