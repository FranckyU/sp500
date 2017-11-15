module Sp500
  class Stock
    using Tools::HashExtensions

    include Tools::HashConstructed

    attr_accessor :ticker_symbol, :nyse_quote_url, :firm_name, :firm_wikipedia_url, :sec_filling_type, :sec_fillings_doc_url, :gics_sector, :gics_sub_industry, :firm_hq_address, :firm_hq_address_url, :sp500_introduction_date, :central_index_key

    class << self
      # generated methods
      # def get_intraday_quotes
      # def get_daily_quotes
      # def get_daily_adjusted_quotes
      # def get_weekly_quotes
      # def get_weekly_adjusted_quotes
      # def get_monthly_quotes
      # def get_monthly_adjusted_quotes
      def generate_quote_methods_for(interval_types)
        interval_types.each do |interval|
          define_method "get_#{interval.gsub('TIME_SERIES_', '').downcase}_quotes" do |args|
            get_quote(args.merge({function: interval}))
          end
        end
      end
    end

    generate_quote_methods_for %w(TIME_SERIES_INTRADAY TIME_SERIES_DAILY TIME_SERIES_DAILY_ADJUSTED TIME_SERIES_WEEKLY TIME_SERIES_WEEKLY_ADJUSTED TIME_SERIES_MONTHLY TIME_SERIES_MONTHLY_ADJUSTED)

    # @param function TIME_SERIES_INTRADAY | TIME_SERIES_DAILY | TIME_SERIES_DAILY_ADJUSTED | TIME_SERIES_WEEKLY | TIME_SERIES_WEEKLY_ADJUSTED | TIME_SERIES_MONTHLY | TIME_SERIES_MONTHLY_ADJUSTED
    # @param interval 1min | 5min | 15min | 30min | 60min (valid for intraday quotes only)
    # @param outputsize compact|full
    # @param datatype json|csv
    def get_quote(function: 'TIME_SERIES_INTRADAY', interval: '60min', outputsize: 'compact', datatype: 'json', debug: false)
      url = build_quote_request_url(
        {
          symbol: @ticker_symbol, 
          function: function, 
          interval: interval, 
          outputsize: outputsize,
          datatype: datatype
        }
      )
    
      JSON.parse(open(url).read)
    rescue Exception => e
      if debug
        return {error: e.message, error_class: e.class.to_s}
      else
        return {}
      end
    end

  private

    def build_quote_request_url(params)
      query = {
        function: 'TIME_SERIES_INTRADAY',
        symbol: 'AAPL',
        interval: '60min',
        apikey: Config.quotes_provider_api_key
      }.merge(params)

      uri = URI::HTTPS.build(:host => Config.quotes_provider_host, path: Config.quotes_request_path, :query => query.to_query)
    end
  end
end
