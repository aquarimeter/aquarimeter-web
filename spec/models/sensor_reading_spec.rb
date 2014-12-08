require 'rails_helper'

RSpec.describe SensorReading, :type => :model do
    before(:each) do
      @reading = FactoryGirl.create(:sensor_reading)
    end

    subject { @reading }

    it { should respond_to(:ph) }
    it { should respond_to(:temperature)}
    it { should respond_to(:aquarium)}
end
