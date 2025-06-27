# frozen_string_literal: true

# app/controllers/pokemons_controller.rb
class PokemonsController < ApplicationController
  CP_MULTIPLIER = {
  1.0 => 0.094,
  1.5 => 0.135137432,
  2.0 => 0.16639787,
  2.5 => 0.192650919,
  3.0 => 0.21573247,
  3.5 => 0.236572661,
  4.0 => 0.25572005,
  4.5 => 0.273530381,
  5.0 => 0.29024988,
  5.5 => 0.306057377,
  6.0 => 0.3210876,
  6.5 => 0.335445036,
  7.0 => 0.34921268,
  7.5 => 0.362457751,
  8.0 => 0.37523559,
  8.5 => 0.387592416,
  9.0 => 0.39956728,
  9.5 => 0.411193551,
  10.0 => 0.42250001,
  10.5 => 0.432926419,
  11.0 => 0.44310755,
  11.5 => 0.453059957,
  12.0 => 0.46279839,
  12.5 => 0.472336083,
  13.0 => 0.48168495,
  13.5 => 0.4908558,
  14.0 => 0.49985844,
  14.5 => 0.508701765,
  15.0 => 0.51739395,
  15.5 => 0.525942511,
  16.0 => 0.5343543,
  16.5 => 0.542635737,
  17.0 => 0.55079269,
  17.5 => 0.558830576,
  18.0 => 0.56675452,
  18.5 => 0.574569153,
  19.0 => 0.58227891,
  19.5 => 0.589887917,
  20.0 => 0.59740001,
  20.5 => 0.604818814,
  21.0 => 0.61215729,
  21.5 => 0.619399365,
  22.0 => 0.62656713,
  22.5 => 0.633644533,
  23.0 => 0.64065295,
  23.5 => 0.647576426,
  24.0 => 0.65443563,
  24.5 => 0.661214804,
  25.0 => 0.667934,
  25.5 => 0.674577537,
  26.0 => 0.68116492,
  26.5 => 0.687680335,
  27.0 => 0.69414365,
  27.5 => 0.700538673,
  28.0 => 0.70688421,
  28.5 => 0.713164996,
  29.0 => 0.71939909,
  29.5 => 0.725571552,
  30.0 => 0.7317,
  30.5 => 0.734741009,
  31.0 => 0.73776948,
  31.5 => 0.740785594,
  32.0 => 0.74378943,
  32.5 => 0.746781211,
  33.0 => 0.74976104,
  33.5 => 0.752729087,
  34.0 => 0.75568551,
  34.5 => 0.758630378,
  35.0 => 0.76156384,
  35.5 => 0.764486565,
  36.0 => 0.76739786,
  36.5 => 0.770297266,
  37.0 => 0.7731865,
  37.5 => 0.776064962,
  38.0 => 0.77893275,
  38.5 => 0.781790055,
  39.0 => 0.78463697,
  39.5 => 0.787473578,
  40.0 => 0.79030001,
  41.0 => 0.79530001,
  42.0 => 0.80030001
}.freeze

  def index
    fetch_pokemon(params[:pokemon_name])
  end

  def calculate_cp
    # max_cp = PogoapiService.get_max_cp_for_pokemon(params[:pokemon_id])
    pokemon_status = PogoapiService.get_pokemon_stats(params[:pokemon_id])

    level = params[:level].to_f
    iv_attack = params[:iv_attack].to_i
    iv_defense = params[:iv_defense].to_i
    iv_stamina = params[:iv_stamina].to_i

    attack = pokemon_status["base_attack"] + iv_attack
    defense = pokemon_status["base_defense"] + iv_defense
    stamina = pokemon_status["base_stamina"] + iv_stamina


    cpm = CP_MULTIPLIER[level]

    @calculated_cp = ((attack * (defense**0.5) * (stamina**0.5) * (cpm**2)) / 10).floor

    @attack = ((pokemon_status["base_attack"] + iv_attack) * cpm).to_i
    @defense = ((pokemon_status["base_defense"] + iv_defense) * cpm).to_i
    @stamina = ((pokemon_status["base_stamina"] + iv_stamina) * cpm).to_i

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def fetch_pokemon(name)
    @pokemon ||= Pokemon.find(name&.downcase || "bulbasaur")
  rescue Pokemon::NotFoundError
    flash.now[:alert] = "Pokémon not found: '#{name}'. Showing Bulbasaur instead."
    Pokemon.find("bulbasaur")
  end
end
