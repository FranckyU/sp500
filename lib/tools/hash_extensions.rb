module Tools
  module HashExtensions
    unless defined? ActiveSupport::CoreExtensions
      refine Hash do
        def to_query
          URI.encode_www_form(self)
        end
      end
    end
  end
end