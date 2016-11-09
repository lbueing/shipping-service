require 'active_shipping'

class ShipmentsController < ApplicationController
  ACTIVESHIPPING_UPS_LOGIN = ENV["ACTIVESHIPPING_UPS_LOGIN"]
  ACTIVESHIPPING_UPS_KEY = ENV["ACTIVESHIPPING_UPS_KEY"]
  ACTIVESHIPPING_UPS_PASSWORD = ENV["ACTIVESHIPPING_UPS_PASSWORD"]
  # ACTIVESHIPPING_UPS_ORIGIN_ACCOUNT = ENV["ACTIVESHIPPING_UPS_ORIGIN_ACCOUNT"]
  # ACTIVESHIPPING_UPS_ORIGIN_NAME = ENV["ACTIVESHIPPING_UPS_ORIGIN_NAME"]




  def cost
    packages = ActiveShipping::Package.new(3*16, [6, 8, 10], units: :imperial)


    origin = ActiveShipping::Location.new(
        country: params[:origin_country],
        state: params[:origin_state],
        city: params[:origin_city],
        zip: params[:origin_zip])

    destination = ActiveShipping::Location.new(
        country: params[:dest_country],
        state: params[:dest_state],
        city: params[:dest_city],
        zip: params[:dest_zip])

    ups = ActiveShipping::UPS.new(login: ACTIVESHIPPING_UPS_LOGIN, password: ACTIVESHIPPING_UPS_PASSWORD, key: ACTIVESHIPPING_UPS_KEY)
    response = ups.find_rates(origin, destination, packages)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

      if ups_rates
        render :json => ups_rates.as_json(), :status => :ok
      else
        render :json => [], :status => :no_content
      end
  end
end
