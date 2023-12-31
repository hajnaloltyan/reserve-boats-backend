class Api::V1::UsersController < ApplicationController
  def index
    users = User.all

    render json: {
      status: { status: 'success', data: users }
    }, status: :ok
  end
end
