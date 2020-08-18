module CurrencyRate
  class CurrencyRateError < StandardError; end

  class StorageNotDefinedError < CurrencyRateError
    def initialize
      super("Storage is not configured for currency-rate gem.")
    end
  end
end
