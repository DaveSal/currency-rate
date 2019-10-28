require "spec_helper"

RSpec.describe CurrencyRate::CoinmonitorAdapter do
  before(:all) { @data, @normalized = data_for :coinmonitor }

  before do
    stub_request(:get, /apilayer/).to_return(body: @data.to_json)
    @adapter = CurrencyRate::CoinmonitorAdapter.instance
  end

  describe "#normalize" do
    it "brings data to canonical form" do
      expect(@adapter.normalize(@data)).to eq(@normalized)
    end
  end
end