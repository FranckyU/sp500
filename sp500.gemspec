
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sp500/version"

Gem::Specification.new do |spec|
  spec.name          = "sp500"
  spec.version       = Sp500::VERSION
  spec.authors       = ["Andy Kifer"]
  spec.email         = ["kifer.mada@gmail.com"]

  spec.summary       = 'Provides data view for the constituents of the S&P 500 stock index'
  spec.description   = 'LIST all 505 S&P500 stocks, list SECTORS and INDUSTRIES, group by GICS SECTOR or INDUSTRY. More features will come.'
  spec.homepage      = "https://github.com/FranckyU/sp500"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "nokogiri", "~> 5.0"
  spec.add_development_dependency "byebug", "~> 5.0"
end
