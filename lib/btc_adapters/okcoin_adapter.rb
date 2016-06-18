module CurrencyRate
  class OkcoinAdapter < BtcAdapter

    FETCH_URL = 'https://www.okcoin.com/api/ticker.do?ok=1'

    def rate_for(to,from)
      super
      raise CurrencyNotSupported if currency_code != 'USD'
      rate = get_rate_value_from_hash(@rates, 'ticker', 'last')
      rate_to_f(rate)
    end

  end
end
