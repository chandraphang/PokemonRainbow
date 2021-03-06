class PokedexesController < ApplicationController
  before_action :set_pokedex, only: [:edit, :update, :destroy]

  # GET /pokedexes
  # GET /pokedexes.json
  def index
    decorator = PokedexDecorator.new(self)
    @decorated_pokedexes = decorator.decorate_for_index(Pokedex.all.order(:id))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokedex"
  end

  # GET /pokedexes/1
  # GET /pokedexes/1.json
  def show
    decorator = PokedexDecorator.new(self)
    @decorated_pokedex = decorator.decorate_for_show(Pokedex.find(params[:id]))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokedex", pokedexes_path
    add_breadcrumb @decorated_pokedex.name

    top_5_pokemon_in_pokedex_by_level = PokemonRainbowStatistic.generate_top_pokemon_in_pokedex_by_level((params[:id]))

    decorator_for_top_5 = PokemonDecorator.new(self)
    @decorated_top_5_pokemon = decorator_for_top_5.decorate_for_top_5_pokemon(top_5_pokemon_in_pokedex_by_level)
  end

  # GET /pokedexes/new
  def new
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokedex", pokedexes_path
    add_breadcrumb "New"
    @pokedex = Pokedex.new
  end

  # GET /pokedexes/1/edit
  def edit
    decorator = PokedexDecorator.new(self)
    @decorated_pokedex = decorator.decorate_for_show(Pokedex.find(params[:id]))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokedexes", pokedexes_path
    add_breadcrumb @decorated_pokedex.name, pokedex_path
    add_breadcrumb "Edit"
  end

  def home
    @top_5_pokemon_winner = PokemonRainbowStatistic.generate_top_5_pokemon_winners
    @top_5_pokemon_loser = PokemonRainbowStatistic.generate_top_5_pokemon_losers
    @top_5_pokemon_surrender = PokemonRainbowStatistic.generate_top_5_pokemon_surrenders
    @top_5_pokemon_win_rate = PokemonRainbowStatistic.generate_top_5_pokemon_win_rates
    @top_5_pokemon_lose_rate = PokemonRainbowStatistic.generate_top_5_pokemon_lose_rates
    @top_5_most_used_pokemon = PokemonRainbowStatistic.generate_top_5_most_used_pokemons
    @top_5_most_used_skill = PokemonRainbowStatistic.generate_top_5_most_used_skills
    @top_5_pokemon_damage = PokemonRainbowStatistic.generate_top_5_pokemon_damages
    @top_5_pokedex_average_levels = PokemonRainbowStatistic.generate_top_5_pokedex_average_level
    add_breadcrumb "Home"
  end

  # POST /pokedexes
  # POST /pokedexes.json
  def create
    @pokedex = Pokedex.new(pokedex_params)

    respond_to do |format|
      if @pokedex.save
        format.html { redirect_to @pokedex, notice: 'Pokedex was successfully created.' }
        format.json { render :show, status: :created, location: @pokedex }
      else
        format.html { render :new }
        format.json { render json: @pokedex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokedexes/1
  # PATCH/PUT /pokedexes/1.json
  def update
    respond_to do |format|
      if @pokedex.update(pokedex_params)
        format.html { redirect_to @pokedex, notice: 'Pokedex was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokedex }
      else
        format.html { render :edit }
        format.json { render json: @pokedex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokedexes/1
  # DELETE /pokedexes/1.json
  def destroy
    @pokedex.destroy
    respond_to do |format|
      format.html { redirect_to pokedexes_url, notice: 'Pokedex was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokedex
      @pokedex = Pokedex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokedex_params
      params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url)
    end
end
