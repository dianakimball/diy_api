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

    def skills
      get("/skills")
    end

    def projects(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/projects?limit=#{options[:limit]}&offset=#{options[:offset]}")
    end

    def explore(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/explore?limit=#{options[:limit]}&offset=#{options[:offset]}")
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

    def stream(id)
      get("/makers/#{id}/stream")
    end

    def tool(id)
      get("/tools/#{id}")
    end

    private

    def get(path)
      @conn.get(path).body.response
    end

  end
end
