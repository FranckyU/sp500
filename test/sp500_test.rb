require "test_helper"

class Sp500Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sp500::VERSION
  end

  def test_sp500_list
    list = Sp500.list

    assert_equal 505, list.length
  end

  def test_sp500_sectors
    sectors = ["Consumer Discretionary", "Consumer Staples", "Energy", "Financials", "Health Care", "Industrials", "Information Technology", "Materials", "Real Estate", "Telecommunication Services", "Utilities"].sort

    assert_equal sectors, Sp500.sectors.sort
  end

  def test_sp500_industries
    industries = {"Industrials"=>["Industrial Conglomerates", "Electrical Components & Equipment", "Airlines", "Building Products", "Aerospace & Defense", "Air Freight & Logistics", "Construction Machinery & Heavy Trucks", "Diversified Support Services", "Railroads", "Industrial Machinery", "Agricultural & Farm Machinery", "Research & Consulting Services", "Construction & Engineering", "Trucking", "Environmental & Facilities Services", "Human Resource & Employment Services", "Trading Companies & Distributors"], "Health Care"=>["Health Care Equipment", "Pharmaceuticals", "Managed Health Care", "Biotechnology", "Health Care Supplies", "Health Care Distributors", "Health Care Technology", "Health Care Facilities", "Health Care Services", "Life Sciences Tools & Services", "Life Sciences Tools & Service"], "Information Technology"=>["IT Consulting & Other Services", "Home Entertainment Software", "Application Software", "Semiconductors", "Internet Software & Services", "Data Processing & Outsourced Services", "Electronic Components", "Technology Hardware, Storage & Peripherals", "Semiconductor Equipment", "Systems Software", "Communications Equipment", "Electronic Equipment & Instruments", "Electronic Manufacturing Services"], "Consumer Discretionary"=>["Automotive Retail", "Internet & Direct Marketing Retail", "Specialty Stores", "Computer & Electronics Retail", "Auto Parts & Equipment", "Hotels, Resorts & Cruise Lines", "Broadcasting", "Cable & Satellite", "Restaurants", "Homebuilding", "General Merchandise Stores", "Apparel Retail", "Automobile Manufacturers", "Consumer Electronics", "Tires & Rubber", "Apparel, Accessories & Luxury Goods", "Motorcycle Manufacturers", "Leisure Products", "Home Improvement Retail", "Advertising", "Home Furnishings", "Distributors", "Department Stores", "Casinos & Gaming", "Housewares & Specialties", "Publishing", "Household Appliances"], "Utilities"=>["Independent Power Producers & Energy Traders", "Electric Utilities", "Multi-Utilities", "Water Utilities"], "Financials"=>["Asset Management & Custody Banks", "Life & Health Insurance", "Property & Casualty Insurance", "Consumer Finance", "Insurance Brokers", "Multi-line Insurance", "Diversified Banks", "Regional Banks", "Multi-Sector Holdings", "Financial Exchanges & Data", "Investment Banking & Brokerage", "Reinsurance", "Thrifts & Mortgage Finance"], "Materials"=>["Industrial Gases", "Specialty Chemicals", "Paper Packaging", "Metal & Glass Containers", "Fertilizers & Agricultural Chemicals", "Diversified Chemicals", "Copper", "Construction Materials", "Gold", "Steel"], "Real Estate"=>["Office REITs", "Specialized REITs", "Residential REITs", "Real Estate Services", "Industrial REITs", "Retail REITs", "Health Care REITs", "Hotel & Resort REITs"], "Consumer Staples"=>["Tobacco", "Agricultural Products", "Distillers & Vintners", "Packaged Foods & Meats", "Household Products", "Soft Drinks", "Hypermarkets & Super Centers", "Personal Products", "Drug Retail", "Food Retail", "Brewers", "Food Distributors"], "Energy"=>["Oil & Gas Exploration & Production", "Oil & Gas Refining & Marketing", "Oil & Gas Equipment & Services", "Integrated Oil & Gas", "Oil & Gas Drilling", "Oil & Gas Storage & Transportation"], "Telecommunication Services"=>["Integrated Telecommunication Services"]}

    assert_equal industries, Sp500.industries
  end

  def test_sp500_by_sectors
    #pp Sp500.by_sectors
  end

  def test_sp500_by_industries
    #pp Sp500.by_industries
  end
end
