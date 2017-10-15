Gem::Specification.new do |s|
  s.name          = 'kele_nkimberly'
  s.version       = '0.0.1'
  s.date          = '2017-10-15'
  s.summary       = 'Kele API Client'
  s.description   = 'A client for the Bloc API'
  s.authors       = ['Kimberly Nguyen']
  s.email         = 'kimberlyvnguyen@gmail.com'
  s.files         = ['lib/kele_nkimberly.rb']
  s.require_paths = ["lib"]
  s.homepage      =
    'http://rubygems.org/gems/kele_nkimberly'
  s.license       = 'MIT'
  # We added a httparty dependency using add_runtime_dependency. This instructs bundle to install httparty, which provides a programmatic Ruby interface to make HTTP requests.
  s.add_runtime_dependency 'httparty', '~> 0.13'
end
