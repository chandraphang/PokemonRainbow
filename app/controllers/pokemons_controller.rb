class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  # GET /pokemons.json
  def index
    @pokemons = Pokemon.all
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
    @pokemon = Pokemon.find(params[:id])
    @pokemon_skills = @pokemon.pokemon_skills
    @pokemon_skill = PokemonSkill.new
  end

  def create_pokemon_skill

    @pokemon_skills = PokemonSkill.all
    @pokemon = Pokemon.find(params[:pokemon_id])
    @pokemon_skill = PokemonSkill.new
    @pokemon_skill.pokemon_id =  params[:pokemon_id]
    @pokemon_skill.skill_id = params[:pokemon_skill][:skill_id]

    @pokemon_skill.current_pp = Skill.find(params[:pokemon_skill][:skill_id]).max_pp



    respond_to do |format|
    if @pokemon_skill.save
        format.html { redirect_to @pokemon, notice: 'Skill was successfully added.' }
        format.json { render :show, status: :created, location: @pokemon }
      else
        format.html { render :show }
        format.json { render json: @pokemon_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_pokemon_skill
    @pokemon = Pokemon.find(params[:pokemon_id])
    @pokemon_skill = PokemonSkill.where(:skill_id => params[:skill_id]).where(:pokemon_id => params[:pokemon_id])
    @pokemon_skill.destroy_all
    respond_to do |format|
      format.html { redirect_to @pokemon, notice: 'Pokemon Skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
  end

  # GET /pokemons/1/edit
  def edit
  end

  # POST /pokemons
  # POST /pokemons.json
  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.level = 1
    @pokemon.max_health_point = Pokedex.find(pokemon_params[:pokedex_id]).base_health_point
    @pokemon.current_health_point = Pokedex.find(pokemon_params[:pokedex_id]).base_health_point
    @pokemon.attack = Pokedex.find(pokemon_params[:pokedex_id]).base_attack
    @pokemon.defence = Pokedex.find(pokemon_params[:pokedex_id]).base_defence
    @pokemon.speed = Pokedex.find(pokemon_params[:pokedex_id]).base_speed
    @pokemon.current_experience = 0
    respond_to do |format|
      if @pokemon.save
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon }
      else
        format.html { render :new }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemons/1
  # PATCH/PUT /pokemons/1.json
  def update
    respond_to do |format|
      if @pokemon.update(pokemon_params)
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokemon }
      else
        format.html { render :edit }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemons/1
  # DELETE /pokemons/1.json
  def destroy
    @pokemon.destroy
    respond_to do |format|
      format.html { redirect_to pokemons_url, notice: 'Pokemon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_params
      params.require(:pokemon).permit(:name, :pokedex_id)
    end


end
