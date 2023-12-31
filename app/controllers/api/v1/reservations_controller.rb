class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = Reservation.includes(:boat).all

    render json: { status: 'success', data: reservations }, status: :ok
  end

  def show
    reservation = Reservation.find(params[:id])

    render json: { status: 'success', data: reservation }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'error', message: 'Reservation not found' }, status: :not_found
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
