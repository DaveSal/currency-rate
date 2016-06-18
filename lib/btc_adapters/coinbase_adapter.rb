module CurrencyRate
  class CoinbaseAdapter < BtcAdapter

    FETCH_URL = 'https://coinbase.com/api/v1/currencies/exchange_rates'

    def rate_for(to,from)
      super
      rate = get_rate_value_from_hash(@rates, "btc_to_#{currency_code.downcase}")
      rate_to_f(rate)
    end

  end
end
