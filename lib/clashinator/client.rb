module Clashinator
  class Client
    CLASH_OF_CLANS_API = 'https://api.clashofclans.com'
    ENDPOINTS = {
      find_clan: '/v1/clans',
      get_clan_info: '/v1/clans/{clan_tag}',
      list_clan_members: '/v1/clans/{clan_tag}/members',
      list_locations: '/v1/locations',
      get_location_info: '/v1/locations/{location_id}',
      get_ranking_for_location: '/v1/locations/{location_id}/rankings/{ranking_id}'
    }

    attr_reader :token

    def initialize(token)
      @token = token
    end

    def method_missing(method_name, *args, &block)
      ENDPOINTS.include?(method_name) ? call(method_name, *args) : super
    end

    def respond_to_missing?(*args)
      ENDPOINTS.include?(args[0]) || super
    end

    def call(method_name, params = {})
      connection_params = build_connection_params(method_name, params)
      response = connection.get(
        connection_params[:url],
        connection_params[:query_params]
      )
      if response.status == 200
        JSON.parse(response.body.to_json)
      else
        raise Exceptions::ResponseError.new(response),
          'Clash of clans API has returned the error.'
      end
    end

    private

    def build_connection_params(method_name, params)
      url = get_url(method_name)
      query_params = ''
      if has_path_param(url)
        params.each do |key, value|
          url.gsub!("{#{key}}", CGI::escape(value.to_s))
        end
        url.gsub!(/\/{\w+}/, '')
      else
        query_params = params
      end
      {url: url, query_params: query_params}
    end

    def get_url(method_name)
      ENDPOINTS[method_name].clone
    end

    def has_path_param(url)
      has_path_param = /{\w+}/ =~ url
      !has_path_param.nil? 
    end

    def connection
      @conn ||= Faraday.new(connection_options) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.response :json#logger
      end
    end

    def connection_options
      {
        url: CLASH_OF_CLANS_API,
        headers: {
          content_type: 'application/json',
          authorization: "Bearer #{token}"
        }
      }
    end
  end
end
