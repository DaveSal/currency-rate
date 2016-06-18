module CurrencyRate
  class BtceAdapter < BtcAdapter

    FETCH_URL = 'https://btc-e.com/api/2/btc_usd/ticker'

    def rate_for(to,from)
      super
      raise CurrencyNotSupported if !FETCH_URL.include?("btc_#{currency_code.downcase}")
      rate = get_rate_value_from_hash(@rates, 'ticker', 'last')
      rate_to_f(rate)
    end

  end
end
