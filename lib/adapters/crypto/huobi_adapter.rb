module CurrencyRate
  class HuobiAdapter < Adapter
    FETCH_URL = "https://api.huobi.pro/market/tickers".freeze

    ANCHOR_CURRENCY = "BTC"

    def normalize(data)
      return nil unless super

      data["data"].each_with_object({ "anchor" => ANCHOR_CURRENCY }) do |pair_info, result|
        pair_name = pair_info["symbol"].upcase
        next unless pair_name.include?(ANCHOR_CURRENCY)

        key = pair_name.sub(ANCHOR_CURRENCY, "")

        result[key] =
          if pair_name.index(ANCHOR_CURRENCY) == 0
            BigDecimal(pair_info["close"].to_s)
          else
            1 / BigDecimal(pair_info["close"].to_s)
          end
      end
    end
  end
end
