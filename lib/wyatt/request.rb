module Wyatt

  module Core

    class Request

      attr_reader   :http_method, :url, :params, :body
      attr_accessor :timeout, :open_timeout

      # TODO (jchristie+nilmethod) validate hhtp method and raise error if invalid
      def initialize(http_method, url, params, body, options={})
        @http_method  = http_method
        @url          = url
        @params       = params || {}
        @body         = body
        @timeout      = options[:timeout]      || 0
        @open_timeout = options[:open_timeout] || 0
      end

      # TODO (jchristie+nilmethod) add all request attributes
      def submit
        execute_request do |request|
          request.timeout      = timeout
          request.open_timeout = open_timeout
        end
      end

      private

      def connection
        Faraday.new(url: url) do |conn|
          conn.request  :json
          conn.response :json, :content_type => /\bjson$/
          conn.adapter  :net_http
        end
      end

      def execute_request(&block)
        connection.send(http_method, &block)
      end

    end

  end

end
