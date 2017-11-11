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
    pp Sp500.sectors
  end

  def test_sp500_industries
    pp Sp500.industries
  end

  def test_sp500_by_sectors
    pp Sp500.by_sectors
  end

  def test_sp500_by_industries
    pp Sp500.by_industries
  end
end
