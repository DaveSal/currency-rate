require "spec_helper"

RSpec.describe CurrencyRate::HitBTCAdapter do
  before(:all) { @data, @normalized = data_for :hitbtc }

  before { @adapter = CurrencyRate::HitBTCAdapter.instance }

  describe "#normalize" do
    it "brings data to cannonical form" do
      expect(@adapter.normalize(@data)).to eq(@normalized)
    end
  end
end
