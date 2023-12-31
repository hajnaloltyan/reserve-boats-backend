class Api::V1::BoatsController < ApplicationController
  # GET /api/v1/boats
  def index
    boats = Boat.all
    render json: { status: 'success', data: boats }, status: :ok
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: :internal_server_error
  end

  # GET /api/v1/boats/:id
  def show
    boat = Boat.find(params[:id])
    render json: { status: 'success', data: boat }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'error', message: 'Boat not found' }, status: :not_found
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/boats/:id
  def destroy
    boat = Boat.find(params[:id])
    boat.destroy!
    render json: { message: 'Boat successfully deleted' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Boat not found' }, status: :not_found
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: "Failed to delete boat: #{e.message}" }, status: :unprocessable_entity
  end

  # POST /api/v1/boats
  def create
    boat = Boat.new(boat_params)
    if boat.save
      render json: { status: 'success', message: 'Boat successfully created', data: boat }, status: :created
    else
      render json: { status: 'error', message: boat.errors }, status: :unprocessable_entity
    end
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :description, :price, :color, :rent_price, :user_id, :picture)
  end
end
