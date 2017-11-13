require 'open-uri'
require 'nokogiri'
require 'date'

require "tools/string_extensions"
require "tools/hash_constructed"

require "sp500/version"
require "sp500/stock"

module Sp500
  using Tools::StringExtension

  class << self
    def list(refresh: false)
      if refresh
        doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"))
        doc.at_xpath("//div[@id='mw-content-text']//table[contains(@class,'wikitable')]").search('tr').map do |row|
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

    private

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