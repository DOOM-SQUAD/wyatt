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
      Faraday.new(url: config.service_root_url) do |conn|
        conn.request  :json
        conn.response :json, :content_type => /\bjson$/
        conn.adapter  :net_http

        conn.headers = { :authorization => config.auth_string }
      end
    end

  end

end
