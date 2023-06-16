class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :authorize

    private

    def authorize 
        render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
    end
end
