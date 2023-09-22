class Api::V1::ReservationsController < ApplicationController
    # before_action :authenticate_user!
    before_action :set_reservation, only: [:show, :destroy]

    def index
    #   reservations = current_user.reservations
      reservations = Reservation.all
      render json: reservations
    end
  
    def show
      render json: @reservation
    end
  
    def create
      reservation = Reservation.new(reservation_params)
  
      if reservation.save
        render json: reservation, status: :created
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @reservation.destroy
      head :no_content
    end
  
    private
  
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :city, :user_id, :motorcycle_id)
    end  
end
