class FlightPassengersController < ApplicationController
  def destroy
    flight_passenger = FlightPassenger.find(params[:id])
    flight_passenger.delete

    redirect_to '/flights'
  end
end
