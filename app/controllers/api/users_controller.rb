module Api
  # Controller that handles authorization and user data fetching
  class UsersController < ApplicationController
    include Devise::Controllers::Helpers

    def login
      user = User.find_by('lower(email) = ?', params[:email])

      if user.blank? || !user.valid_password?(params[:password])
        render json: {
          errors: [
            'Invalid email/password combination'
          ]
        }, status: :unauthorized
        return
      end

      sign_in(:user, user)

      render json: {
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          token: current_token
        }
      }.to_json
    end

    def show
      user = User.find_by(id: params[:id])

      if user.nil?
        render json: {
          errors: [
            'Golfer with this id was not found'
          ]
        }, status: :not_found
      else
        render json: {
          user: {
            id: user.id,
            name: user.name,
            scores: user.scores.map(&:serialize)
          }
        }.to_json
      end
    end
  end
end
