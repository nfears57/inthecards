class SessionsController < ApplicationController
    skip_before_action :authorize, only: [:create, :is_logged_in?, :destroy]
    # skip_before_action :verify_authenticity_token


    def create
        user = User.find_by(email: session_params[:email])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {errors: ["Invalid email or password"]}, status: :unauthorized
        end
    end

    def is_logged_in?
        @current_user = User.find(session[:user_id]) if session[:user_id]
        if @current_user
          render json: {
            logged_in: true,
            user: UserSerializer.new(@current_user)
          }
        else
          render json: {
            logged_in: false
          }
        end
    end
    # login then logout

    def destroy
        session.delete :user_id
        render json: {
            status: 200,
            logged_out: true
          }
    end

    private
    def session_params
      params.permit(:email, :password)
    end
end
