module ConfBot
  class Config
    @headers : Hash(String, String) # Hash (and other complex types) types cannot be declared with generic inner types
    @base_url : String
    @limit : String
    @params : Hash(Symbol, String | Array(String)) # String | Array(String) is a union type

    def initialize
      @base_url = get_env "CONF_ATLASSIAN_URL", "https://spantreellc.atlassian.net/wiki/rest/api"
      @rest_endpoint = "#{@base_url}/content"
      @headers = headers(get_env "CONF_ATLASSIAN_TOKEN")
      @limit = get_env "CONF_ATLASSIAN_QUERY_LIMIT", "200"
      @params = params(@limit, ["history.lastUpdated"])
    end

    def rest_endpoint
      @rest_endpoint
    end

    private def params(limit, expand_options)
      Hash{
        :limit => limit,
        :expand => ["history.lastUpdated"]
      }
    end

    def params
      @params
    end

    private def headers(auth_token)
      Hash{
        "Authorization" => "Basic #{auth_token}",
        "Accept" => "application/json",
      }
    end

    def headers
      @headers
    end

    def printenv
      puts @rest_endpoint
      puts @headers
      puts @params
    end

    private def get_env(variable)
      get_env variable, ""
    end

    private def get_env(variable, default)
      if ENV.has_key?(variable)
        ENV[variable]
      elsif default != ""
        default
      else
        raise("#{variable} is undefined set it in the environment.")
      end
    end
  end
end
# @rest_endpoint = "#{@base_url}/content?expand=history.lastUpdated&limit=#{@limit}"

