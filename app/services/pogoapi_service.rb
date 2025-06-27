# frozen_string_literal: true

# app/services/pogoapi_service.rb
class PogoapiService
  include HTTParty
  base_uri "https://pogoapi.net"

  def self.get_max_cp_for_pokemon(pokemon_id)
    response = get("/api/v1/pokemon_max_cp.json")
    all_max_cp = response.success? ? response.parsed_response : []


    pokemon_cp_info = all_max_cp.find { |p| p["pokemon_id"].to_i == pokemon_id.to_i }
    pokemon_cp_info ? pokemon_cp_info["max_cp"] : nil
  end

  def self.get_pokemon_stats(pokemon_id)
    response = get("/api/v1/pokemon_stats.json")
    return nil unless response.success?

    all_stats = response.parsed_response
    all_stats.find { |p| p["pokemon_id"].to_i == pokemon_id.to_i }
  end
end
