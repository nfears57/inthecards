class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
skip_before_action :authorize, only: [:create, :show, :index, :update, :update_balance]

def index
    @users = User.all
    render json: @users
end

def show
  user = User.find_by(id: session[:user_id])
  if user
    render json: user
  else
    render json: { message: "User not authenticated" }, status: :unauthorized
  end
end

def create
  user = User.create!(user_params)
  session[:user_id] = user.id
  render json: user, status: :created
end

def update_balance
  user = User.find(params[:id])
  user.account_balance = params[:account_balance]
  user.save
  render json: user
end

def destroy
  user = User.find(params[:id])
  user.destroy
  head :no_content
end

private

    def user_params
      params.permit(:name, :email, :password, :age, :balance)
    end

    def render_not_found_response
        render json: { error: "User not found" }, status: :not_found
      end

      def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
