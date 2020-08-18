module CurrencyRate
  class FileStorage
    attr_reader   :path
    attr_accessor :serializer

    def initialize(path:, serializer: nil)
      @path       = path
      @serializer = serializer || Storage::YAMLSerializer.new
    end

    def read(exchange_name)
      path = path_for exchange_name.downcase
      @serializer.deserialize File.read(path)
    rescue StandardError => e
      CurrencyRate.logger.error(e)
      nil
    end

    def write(exchange_name, data = "")
      File.write path_for(exchange_name.downcase), @serializer.serialize(data)
    rescue StandardError => e
      CurrencyRate.logger.error(e)
    end

    def path_for(exchange_name)
      File.join @path, "#{exchange_name}_rates.yml"
    end
  end
end
