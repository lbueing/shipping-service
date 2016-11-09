require 'active_shipping'

class ShipmentsController < ApplicationController
  ACTIVESHIPPING_UPS_LOGIN = ENV["ACTIVESHIPPING_UPS_LOGIN"]
  ACTIVESHIPPING_UPS_KEY = ENV["ACTIVESHIPPING_UPS_KEY"]
  ACTIVESHIPPING_UPS_PASSWORD = ENV["ACTIVESHIPPING_UPS_PASSWORD"]
  # ACTIVESHIPPING_UPS_ORIGIN_ACCOUNT = ENV["ACTIVESHIPPING_UPS_ORIGIN_ACCOUNT"]
  # ACTIVESHIPPING_UPS_ORIGIN_NAME = ENV["ACTIVESHIPPING_UPS_ORIGIN_NAME"]

  def cost
    Rails.logger.debug(params[:shipment])
    Rails.logger.debug(params[:shipment][:destination_address])
    Rails.logger.debug(params[:shipment][:destination_address])


    # {
    # 	"shipment": { "destination_address": { "city": "Seattle", "state": "WA", "zip": "98122"},
    # 	"origin_address": { "city": "Seattle", "state": "WA", "zip": "98122"},
    # 	"packages": [{"weight": "100", "dimensions": [15,10, 4.5], "units": "imperial"}]
    #
    #
    # 	}
    # }

    packages = ActiveShipping::Package.new(3*16, [6, 8, 10], units: :imperial)


    origin = ActiveShipping::Location.new(
        country: 'US',
        state: 'WA',
        city: 'Seattle',
        zip: '98125')

    destination = ActiveShipping::Location.new(
        country: 'US',
        state: 'KS',
        city: 'Topeka',
        zip: '66601')

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
