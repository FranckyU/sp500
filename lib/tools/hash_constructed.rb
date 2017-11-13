module Tools
  module HashConstructed
    def initialize(h)
      h.each {|attr_name,attr_value| public_send("#{attr_name}=", attr_value)}
    end
  end
end