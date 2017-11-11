require 'open-uri'
require 'nokogiri'
require 'pp'
require 'byebug'
require 'date'

require "sp500/version"

module Sp500
  using StringExtension

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

        {
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
        }
      end.compact
    end

    def sectors
      list.map do |item| 
        item[:gics_sector]
      end.uniq.sort
    end

    def industries
      result = {}

      list.each do |item| 
        result[item[:gics_sector]] ||= []
        result[item[:gics_sector]] << item[:gics_sub_industry] unless result[item[:gics_sector]].include?(item[:gics_sub_industry])
      end

      result
    end

    def by_sectors
      result = {}

      list.each do |item|
        result[item[:gics_sector]] ||= []
        result[item[:gics_sector]] << item
      end

      result
    end

    def by_industries
      result = {}

      list.each do |item| 
        result[item[:gics_sector]] ||= {}
        result[item[:gics_sector]][item[:gics_sub_industry]] ||= []
        result[item[:gics_sector]][item[:gics_sub_industry]] << item
      end

      result
    end
  end
