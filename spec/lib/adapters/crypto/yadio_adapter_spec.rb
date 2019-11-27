require "spec_helper"

RSpec.describe CurrencyRate::YadioAdapter do
  before(:all) { @data, @normalized = data_for :yadio }

  before { @adapter = CurrencyRate::YadioAdapter.instance }

  describe "#normalize" do
    it "brings data to cannonical form" do
      expect(@adapter.normalize(@data)).to eq(@normalized)
    end
  end
end
