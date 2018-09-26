require "crest"
require "json"

module ConfBot
  module Confluence
    extend self # lets you call the module functions using the namespace (eg: ConfBot::Confluence.get_posts)

    def get_posts(config)
      response = Crest::Request.execute(
        :get,
        config.rest_endpoint,
        params: config.params,
        headers: config.headers
      )

      if status_code = response.try(&.status_code) == 200
        resp = JSON.parse(response.try(&.body))
      else
        raise("HTTP error: #{status_code}")
      end

      Hash{ "total_posts" => resp["size"], "posts" => resp["results"]}
    end
  end
end

