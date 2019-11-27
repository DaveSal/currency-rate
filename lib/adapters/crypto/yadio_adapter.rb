module CurrencyRate
  class YadioAdapter < Adapter
    SUPPORTED_CURRENCIES = %w(VES)

    ANCHOR_CURRENCY = "BTC"

    FETCH_URL = "https://api.yadio.io/rate/BTC"

    def normalize(data)
      return nil unless super

      {
        "anchor" => ANCHOR_CURRENCY,
        "USD" => BigDecimal(data["usd"].to_s),
        "VES" => BigDecimal(data["rate"].to_s),
      }
    end
  end
end
