# frozen_string_literal: true

# app/models/concerns/pokeapi_fetcher.rb
module PokeapiFetcher
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    attr_accessor :id, :name, :sprites, :types, :abilities, :stats

    def self.find(id_or_name)
      poke_info = ::PokeapiService.get_pokemon(id_or_name)
      return nil unless poke_info

      new(
        id: poke_info["id"],
        name: poke_info["name"],
        sprites: poke_info["sprites"],
        types: poke_info["types"].map { |type_info| type_info["type"]["name"] },
        abilities: poke_info["abilities"].map { |ability_info| ability_info["ability"]["name"] },
        stats: poke_info["stats"].map do |stat_info|
                 { name: stat_info["stat"]["name"], base_stat: stat_info["base_stat"] }
               end
      )
    end
  end
end
