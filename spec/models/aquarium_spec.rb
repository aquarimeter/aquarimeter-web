require 'rails_helper'

RSpec.describe Aquarium, :type => :model do
  before(:each) do
    @aquarium = FactoryGirl.create(:aquarium)
  end

  subject { @aquarium }

  it { should respond_to(:name) }
  it { should respond_to(:ideal_temp_low)}
  it { should respond_to(:ideal_temp_high)}
  it { should respond_to(:user)}

end
