require 'faraday'
require 'faraday_middleware/response/rashify'
require 'faraday_middleware/response/parse_json'

BASE_URL = 'https://api.diy.org'

module DIY
  class Client
    def initialize(api_key)
      @api_key = api_key
      @conn = Faraday.new(:url => BASE_URL) do |builder|
        builder.headers = {'x-diy-api-key' => @api_key, 'Accept-Version' => '~1.4'}
        builder.use Faraday::Response::Rashify
        builder.use Faraday::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end

    def skills(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/skills", options)
    end

    def projects(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/projects", options)
    end

    def tools(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/tools", options)
    end

    def maker(id)
      get("/makers/#{id}")
    end

    def project(id)
      get("/projects/#{id}")
    end

    def skill(id)
      get("/skills/#{id}")
    end

    def tool(id)
      get("/tools/#{id}")
    end

    private

    def get(path, params={})
      faraday_response = @conn.get(path) do |request|
        request.params.update(params)
      end
      faraday_response.body.response
    end

  end
end
