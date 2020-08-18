require "spec_helper"

RSpec.describe CurrencyRate::PoloniexAdapter do
  before(:all) { @data, @normalized = data_for :poloniex }

  before { @adapter = CurrencyRate::PoloniexAdapter.instance }

  describe "#normalize" do
    it "brings data to cannonical form" do
      expect(@adapter.normalize(@data)).to eq(@normalized)
    end
  end
end
