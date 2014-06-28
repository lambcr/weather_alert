require 'json'
require 'rest_client'
require 'hashie'

module WeatherAlert
  class Wunderground
    attr_reader :state, :city, :token

    def initialize(state, city, token)
      @state = state
      @city = city
      @token = token
    end

    def conditions
      @conditions ||= call_and_parse(conditions_endpoint).current_observation
    end

    def forecast
      @forecast ||= call_and_parse(forecast_endpoint).forecast
    end

    private

    def conditions_endpoint
      @conditions_endpoint ||= "#{base_endpoint}/conditions/q/#{state_param}/#{city_param}.json"
    end

    def forecast_endpoint
      @forecast_endpoint ||= "#{base_endpoint}/forecast/q/#{state_param}/#{city_param}.json"
    end

    def base_endpoint
      @base_endpoint ||= "http://api.wunderground.com/api/#{token}"
    end

    def current_conditions
      call_and_parse(conditions_endpoint).current_observation
    end

    def current_forecast
      call_and_parse(forecast_endpoint).forecast
    end

    def call_and_parse(url)
      #TODO: Add Error Handling.
      #TODO: Add logging.
      response = RestClient.get(url)
      Hashie::Mash.new(JSON.parse(response))
    end

    def state_param
      @sp ||= state.to_s.downcase
    end

    def city_param
      @cp ||= city.to_s.downcase.gsub(' ', '_')
    end
  end
end
