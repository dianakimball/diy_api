require 'faraday'
require 'faraday_middleware/response/rashify'
require 'faraday_middleware/response/parse_json'

BASE_URL = 'https://api.diy.org'

module DIY
  class Client
    def initialize(api_key, api_version = '~1.4')
      @api_key = api_key
      @api_version = api_version
      @conn = Faraday.new(:url => BASE_URL) do |builder|
        builder.headers = {'x-diy-api-key' => @api_key, 'Accept-Version' => @api_version}
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end

    def maker(id)
      get("/makers/#{id}")
    end

    def action_stream(id)
      get("/makers/#{id}/stream")
    end

    def activity_stream(id)
      get("/makers/#{id}/following/stream")
    end

    def projects_by_maker(id)
      get("/makers/#{id}/projects")
    end

    def achievements_by_maker(id)
      get("/makers/#{id}/achievements")
    end

    def favorites_of_maker(id)
      get("/makers/#{id}/favorites")
    end

    def followers_of_maker(id)
      get("/makers/#{id}/followers")
    end

    def follows_of_maker(id)
      get("/makers/#{id}/following")
    end

    def project(id)
      get("/projects/#{id}")
    end

    def comments_on_project(id)
      get("/projects/#{id}/comments")
    end

    def projects(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/projects", options)
    end

    def skill(id)
      get("/skills/#{id}")
    end

    def challenges_for_skill(id)
      get("/skills/#{id}/challenges")
    end

    def skills(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/skills", options)
    end

    def tool(id)
      get("/tools/#{id}")
    end

    def tools(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/tools", options)
    end

    def explore(options={})
      options[:limit] ||= 100
      options[:offset] ||= 0
      get("/explore", options)
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
