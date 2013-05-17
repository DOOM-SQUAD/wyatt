module Wyatt

  class Request
    attr_reader   :http_method, :uri, :params, :body
    attr_accessor :timeout, :open_timeout

    def initialize(http_method, uri, params, body, options)
      @http_method  = http_method
      @uri          = uri
      @params       = params || {}
      @body         = body
      @timeout      = options[:timeout]
      @open_timeout = options[:open_timeout]
    end

    private

    def connection
      # implicitly build a faraday connection 
    end

  end

end
