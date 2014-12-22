require 'rails_helper'

RSpec.describe Aquarium, :type => :model do
  before(:each) do
    @aquarium = FactoryGirl.create(:aquarium)
    @aquarium_low_high = FactoryGirl.build(:aquarium, :ideal_temp_low => 3, :ideal_temp_high => 0)
    @aquarium_high_low = FactoryGirl.build(:aquarium, :ideal_temp_low => 82, :ideal_temp_high => 844)
  end

  subject { @aquarium }

  it { should respond_to(:name) }
  it { should respond_to(:ideal_temp_low)}
  it { should respond_to(:ideal_temp_high)}
  it { should respond_to(:user)}

  subject {@aquarium_high_low}

  it {should_not be_valid}

  subject {@aquarium_low_high}

  it {should_not be_valid}

end
