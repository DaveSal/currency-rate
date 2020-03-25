module CurrencyRate
  class PaxfulAdapter < Adapter
    SUPPORTED_CURRENCIES = %w(USD)

    ANCHOR_CURRENCY = "BTC"

    FETCH_URL = "https://paxful.com/api/currency/btc"

    def normalize(data)
      return nil unless super

      {
        "anchor" => ANCHOR_CURRENCY,
        "USD" => BigDecimal(data["price"].to_s)
      }
    end
  end
end
