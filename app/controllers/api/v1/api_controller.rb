module Api
  module V1
    class ApiController < ApplicationController
      def not_found
        render json: { error: 'page not found' }
      end
    
      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])
            session[:current_user] = @current_user.id
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
      end  

      def current_user
        @user ||= User.find(session[:current_user])
        @user
      end
    end
  end
end