module Wyatt

  class Response

    attr_reader :faraday_response

    def initialize(faraday_response)
      @faraday_response = faraday_response
    end

    def body
      faraday_response.body
    end

    def status
      faraday_response.status
    end

    def success?
      (200..299).include?(status)
    end

  end

end
