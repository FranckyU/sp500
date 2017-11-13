module Sp500
  class Stock
    include Tools::HashConstructed

    attr_accessor :ticker_symbol, :nyse_quote_url, :firm_name, :firm_wikipedia_url, :sec_filling_type, :sec_fillings_doc_url, :gics_sector, :gics_sub_industry, :firm_hq_address, :firm_hq_address_url, :sp500_introduction_date, :central_index_key
  end
end
