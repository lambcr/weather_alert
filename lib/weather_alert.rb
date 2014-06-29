require "weather_alert/version"
require "weather_alert/wunderground"
require "weather_alert/emails"

module WeatherAlert
  def self.for_john(email_address)
    token = ENV['WUNDERGROUND_TOKEN']
    florida_conditions = Wunderground.new('FL', 'Saint_Petersburg', token).conditions
    chicago_conditions = Wunderground.new('IL', 'Chicago', token).conditions

    email = Emails::CurrentConditions.new(
      email_address,
      florida_conditions,
      chicago_conditions
    )
    email.send
  end
end
