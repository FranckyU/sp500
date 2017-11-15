module Tools
  module StringExtensions
    unless defined? ActiveSupport::CoreExtensions
      refine String do
        def blank?
          length() == 0 || match(/^\s+$/)
        end
      end
    end
  end
end