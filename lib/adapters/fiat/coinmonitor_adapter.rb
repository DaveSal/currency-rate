module CurrencyRate
  class CoinmonitorAdapter < Adapter
    # No need to use it for fetching, just additional information about supported currencies
    SUPPORTED_CURRENCIES = %w(ARS)
    ANCHOR_CURRENCY = "USD"
    FETCH_URL = "https://ar.coinmonitor.info/api/dolar_ar/"

    def normalize(data)
      return nil unless super

      { "anchor" => ANCHOR_CURRENCY }.merge({ SUPPORTED_CURRENCIES.first => BigDecimal(data["DOL_blue"].to_s) })
    end
  end
end