require 'spec_helper'

module WeatherAlert
  describe Wunderground do
    let(:city) { 'Saint Petersburg' }
    let(:state) { 'FL' }
    let(:token) { 'atoken' }
    subject { described_class.new(state, city, token) }

    describe "#conditions" do
      context "when request is successful" do
        before do
          stub_request(:get, "http://api.wunderground.com/api/atoken/conditions/q/fl/saint_petersburg.json").
            to_return(status: 200, body: IO.read('spec/support/conditions.json'), headers: {})
        end

        it "returns a hashie mash of conditions" do
          expect(subject.conditions).to be_instance_of(Hashie::Mash)
        end
        it "has the current temperature string" do
          expect(subject.conditions.temperature_string).to eq('79.9 F (26.6 C)')
        end
        it "has the temperature" do
          expect(subject.conditions.temp_f).to eq(79.9)
        end
        it "has the display location" do
          expect(subject.conditions.display_location.full).to eq('Saint Petersburg, FL')
        end
      end
    end

    describe "#forecast" do
      context "when request is successful" do
        before do
          stub_request(:get, "http://api.wunderground.com/api/atoken/forecast/q/fl/saint_petersburg.json").
            to_return(status: 200, body: IO.read('spec/support/forecast.json'), headers: {})
        end

        it "returns a hashie mash of conditions" do
          expect(subject.forecast).to be_instance_of(Hashie::Mash)
        end
      end
    end
  end
end
