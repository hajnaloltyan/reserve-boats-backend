class Api::V1::ReservationsController < ApplicationController
  def index
    user_name = request.headers['Authorization']
    current_user = User.find_by(name: user_name)
    if current_user
      reservations = Reservation.includes(:boat).where(username: current_user.name).order(created_at: :desc)
      reservations_with_boat_name = reservations.map do |reservation|
        reservation.attributes.merge(boat_name: reservation.boat.name)
      end
      render json: { status: 'success', data: reservations_with_boat_name }, status: :ok
    else
      render json: { status: 'error', message: 'User not found' }, status: :not_found
    end
  end

  def create
    reservation = Reservation.new(reservations_params)

    if reservation.save
      render json: { status: 'success', message: 'Boat successfully reserved', data: reservation },
             status: :created
    else
      render json: { status: 'error', message: reservation.errors }, status: :unprocessable_entity
    end
  end

  private

  def reservations_params
    params.require(:reservation).permit(:username, :city, :date, :boat_id)
  end
end
