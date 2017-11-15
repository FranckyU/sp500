require 'pp'
require 'open-uri'
require 'date'
require 'json'
require 'byebug'
require 'nokogiri'

require "tools/string_extensions"
require "tools/hash_extensions"
require "tools/hash_constructed"

require "sp500/version"
require "sp500/config"
require "sp500/stock"

module Sp500
  using Tools::StringExtensions
  using Tools::HashExtensions

  class << self
    def list(refresh: false)
      if refresh
        rows_from_wiki_source.map do |row|
          stock_from_wiki_html_table_row(format_wiki_html_table_row(row))
        end.compact
      else
        # tada
      end
    end

    def sectors(refresh: false)
      list(refresh: refresh).map do |stock| 
        stock.gics_sector
      end.uniq.sort
    end

    def industries(refresh: false)
      result = {}

      list(refresh: refresh).each do |stock| 
        result[stock.gics_sector] ||= []
        result[stock.gics_sector] << stock.gics_sub_industry unless result[stock.gics_sector].include?(stock.gics_sub_industry)
      end

      result
    end

    def by_sectors(refresh: false)
      result = {}

      list(refresh: refresh).each do |stock|
        result[stock.gics_sector] ||= []
        result[stock.gics_sector] << stock
      end

      result
    end

    def by_industries(refresh: false)
      result = {}

      list(refresh: refresh).each do |stock| 
        result[stock.gics_sector] ||= {}
        result[stock.gics_sector][stock.gics_sub_industry] ||= []
        result[stock.gics_sector][stock.gics_sub_industry] << stock
      end

      result
    end

    def configure_with_alpha_vantage_quotes_provider
      Config.configure do |config|
        config.quotes_provider_host = 'www.alphavantage.co'
        config.quotes_request_path = '/query'

        alpha_api_key_file = File.expand_path('~/.alpha_vantage')

        config.quotes_provider_api_key = if File.exists?(alpha_api_key_file)
          api_key = 'demo'
          begin
            file = File.open(alpha_api_key_file)
            api_key = file.read.gsub(/\n/, '').gsub('API_KEY=', '')
          ensure
            file.close
          end
        end

        config.quotes_provider_api_key = 'demo' if config.quotes_provider_api_key.nil?
      end
    end

    private

    def rows_from_wiki_source
      Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies")).at_xpath("//div[@id='mw-content-text']//table[contains(@class,'wikitable')]").search('tr')
    end

    def stock_from_wiki_html_table_row(data)
      return nil if data.empty?

      Stock.new(
        ticker_symbol: data[0][0],
        nyse_quote_url: data[0][1],
        firm_name: data[1][0],
        firm_wikipedia_url: data[1][1],
        sec_filling_type: data[2][0],
        sec_fillings_doc_url: data[2][1],
        gics_sector: data[3],
        gics_sub_industry: data[4],
        firm_hq_address: data[5][0],
        firm_hq_address_url: data[5][1],
        sp500_introduction_date: (data[6].blank? ? 'n/a' : Date.parse(data[6])),
        central_index_key: data[7]
      )
    end

    def format_wiki_html_table_row(row)
      row.search('td').map do |cell| 
        if cell.search('a').length > 0
          [
            cell.search('a')[0].text.strip, 
            cell.search('a')[0]['href']
          ]
        else
          cell.text.strip
        end
      end
    end
  end
end