module WeatherAlert
  module Emails
    class CurrentConditions
      attr_reader :recipient_email, :base_conditions, :comparison_conditions

      def initialize(recipient_email, base_conditions, comparison_conditions)
        @recipient_email       = recipient_email
        @base_conditions       = base_conditions
        @comparison_conditions = comparison_conditions
      end

      def send
        smtp = Net::SMTP.new('smtp.gmail.com', 587)
        smtp.enable_starttls
        smtp.start('gmail.com', gmail_user, gmail_password, :login) do
          smtp.send_message(message, gmail_user, recipient_email)
        end
      end

      def message
        <<-EOS
From: Chris Lamb <#{gmail_user}>
To:  #{recipient_email}
Subject: Greetings From #{base_conditions.display_location.full}!

Hello!

The current temperature in #{base_conditions.display_location.full} is: #{base_conditions.temperature_string}

The current temperature in #{comparison_conditions.display_location.full} is: #{comparison_conditions.temperature_string}

That is a difference of #{(base_conditions.temp_f - comparison_conditions.temp_f).round(2)} F!

You are welcome.

Sincerely,
RoboChris
        EOS
      end

      private

      def gmail_user
        #TODO: Use configuration instead of environment variable.
        @gmail_user ||= ENV['GMAIL_USER']
      end

      def gmail_password
        #TODO: Use configuration instead of environment variable.
        @gmail_password ||= ENV['GMAIL_PASSWORD']
      end
    end
  end
end
