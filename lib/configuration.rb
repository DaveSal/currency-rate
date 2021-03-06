module CurrencyRate
  class Configuration
    attr_accessor :api_keys
    attr_accessor :logger
    attr_accessor :crypto_adapters
    attr_accessor :fiat_adapters
    attr_accessor :connect_timeout
    attr_accessor :read_timeout
    attr_accessor :storage
    attr_accessor :limit_sources_for_fiat_currencies
    attr_accessor :crypto_currencies

    def initialize
      @api_keys         = { }
      @logger           = {
                            device: $stdout,
                            level:  :info,
                            formatter: nil,
                          }
       @crypto_adapters = CurrencyRate.adapters :crypto
       @fiat_adapters   = CurrencyRate.adapters :fiat
       @connect_timeout = 4
       @read_timeout    = 4
       @limit_sources_for_fiat_currencies = {}
       @crypto_currencies = []
    end
  end
end
