module CurrencyRate
  class Fetcher
    attr_accessor :storage
    attr_accessor :fiat_exchanges
    attr_accessor :crypto_exchanges
    attr_accessor :limit_sources_for_fiat_currencies

    def initialize(fiat_exchanges: nil, crypto_exchanges: nil, storage: nil, limit_sources_for_fiat_currencies: {})
      @storage = storage || FileStorage.new
      @fiat_exchanges = fiat_exchanges || ["Yahoo", "Fixer", "Forge"]
      @crypto_exchanges = crypto_exchanges || ["Bitstamp", "Binance"]
      @limit_sources_for_fiat_currencies = limit_sources_for_fiat_currencies
    end

    def fetch_crypto(exchange, from, to)
      from = from.strip.upcase
      to = to.strip.upcase
      rates = @storage.read(exchange)

      if rates.nil?
        CurrencyRate.logger.warn("Fetcher#fetch_crypto: rates for #{exchange} not found in storage <#{@storage.class.name}>")
        return nil
      end

      rate = calculate_rate(rates, from, to)
      return rate unless rate.nil?

      if to != "USD"
        usd_fiat = fetch_fiat("USD", to)
        return BigDecimal(rates["USD"] * usd_fiat) if usd_fiat && rates["USD"]
      end
      nil
    end

    def fetch_fiat(from, to)
      from = from.strip.upcase
      to = to.strip.upcase

      exchanges = @fiat_exchanges.dup
      exchanges += @crypto_exchanges if is_crypto_currency?(from) || is_crypto_currency?(to)

      if(@limit_sources_for_fiat_currencies[from])
        exchanges.select! { |ex| @limit_sources_for_fiat_currencies[from].include?(ex) }
      end
      if(@limit_sources_for_fiat_currencies[to])
        exchanges.select! { |ex| @limit_sources_for_fiat_currencies[to].include?(ex) }
      end

      exchanges.each do |exchange|
        rates = @storage.read(exchange)
        next if rates.nil?

        rate = calculate_rate(rates, from, to)
        return rate unless rate.nil?
      end
      nil
    end

    private

      def calculate_rate(rates, from, to)
        anchor = rates.delete("anchor")

        return BigDecimal(rates[to])               if anchor == from && rates[to]
        return BigDecimal(1 / rates[from])         if anchor == to && rates[from]
        return BigDecimal(rates[to] / rates[from]) if rates[from] && rates[to]

        CurrencyRate.logger.warn("Fetcher: rate for #{from}_#{to} not found.")
        nil
      end

      def is_crypto_currency?(currency)
        CurrencyRate.configuration.crypto_currencies.include?(currency)
      end

  end
end

