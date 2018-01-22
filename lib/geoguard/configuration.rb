module GeoGuard
  class Configuration
    FORMATS = %i[CSV MMDB ZIP]
    class InvalidFormat < RuntimeError ; end

    attr_accessor :client_id, :license, :host
    attr_reader :format

    def initialize
      @format = :CSV
    end

    def format=(format)
      raise InvalidFormat, "#{format} is not a valid format. Only #{FORMATS} are allowed." unless FORMATS.include?(format)
      @format = format
    end
  end
end
