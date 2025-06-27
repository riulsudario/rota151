# frozen_string_literal: true

# app/services/pokeapi_service.rb
require "httparty"

class PokeapiService
  include HTTParty
  base_uri "https://pokeapi.co/api/v2"

  def self.get_pokemon(id_or_name)
    response = get("/pokemon/#{id_or_name.to_s.downcase}")
    return nil unless response.success?

    response.parsed_response
  end
end
