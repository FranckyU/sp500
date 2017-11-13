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
    def list
      doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"))

      doc.at_xpath("//div[@id='mw-content-text']//table[contains(@class,'wikitable')]").search('tr').map do |row|
        cells = row.search('td').map do |cell| 
          if cell.search('a').length > 0
            [
              cell.search('a')[0].text.strip, 
              cell.search('a')[0]['href']
            ]
          else
            cell.text.strip
          end
        end

        next if cells.empty?

        Stock.new(
          ticker_symbol: cells[0][0],
          nyse_quote_url: cells[0][1],
          firm_name: cells[1][0],
          firm_wikipedia_url: cells[1][1],
          sec_filling_type: cells[2][0],
          sec_fillings_doc_url: cells[2][1],
          gics_sector: cells[3],
          gics_sub_industry: cells[4],
          firm_hq_address: cells[5][0],
          firm_hq_address_url: cells[5][1],
          sp500_introduction_date: (cells[6].blank? ? 'n/a' : Date.parse(cells[6])),
          central_index_key: cells[7]
        )
      end.compact
    end

    def sectors
      list.map do |stock| 
        stock.gics_sector
      end.uniq.sort
    end

    def industries
      result = {}

      list.each do |stock| 
        result[stock.gics_sector] ||= []
        result[stock.gics_sector] << stock.gics_sub_industry unless result[stock.gics_sector].include?(stock.gics_sub_industry)
      end

      result
    end

    def by_sectors
      result = {}

      list.each do |stock|
        result[stock.gics_sector] ||= []
        result[stock.gics_sector] << stock
      end

      result
    end

    def by_industries
      result = {}

      list.each do |stock| 
        result[stock.gics_sector] ||= {}
        result[stock.gics_sector][stock.gics_sub_industry] ||= []
        result[stock.gics_sector][stock.gics_sub_industry] << stock
      end

      result
    end
  end
end