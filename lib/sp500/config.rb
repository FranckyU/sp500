module Sp500
  class Config
    class << self
      attr_accessor :quotes_provider_host, :quotes_request_path, :quotes_provider_api_key

      def configure(&block)
        yield self
      end
    end
  end
end