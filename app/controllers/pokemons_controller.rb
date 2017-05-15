class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  # GET /pokemons.json
  def index
    decorator = PokemonDecorator.new(self)
    @decorated_pokemons = decorator.decorate_for_index(Pokemon.all)
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
    pokemon = Pokemon.find(params[:id])

    decorator = PokemonDecorator.new(self)
    @decorated_pokemon = decorator.decorate_for_show(pokemon)

    decorator_pokemon_skill = PokemonSkillDecorator.new(self)
    @decorated_pokemon_skills = decorator_pokemon_skill.decorate_for_index(pokemon.pokemon_skills)

    @pokemon_skill = PokemonSkill.new
  end

  def create_pokemon_skill

    pokemon = Pokemon.find(params[:pokemon_id])
    @pokemon_skill = PokemonSkill.new
    @pokemon_skill.pokemon_id =  params[:pokemon_id]
    @pokemon_skill.skill_id = params[:pokemon_skill][:skill_id]
    if params[:pokemon_skill][:skill_id].present?
      @pokemon_skill.current_pp = Skill.find(params[:pokemon_skill][:skill_id]).max_pp
    end

    decorator = PokemonDecorator.new(self)
    @decorated_pokemon = decorator.decorate_for_show(pokemon)

    decorator_pokemon_skill = PokemonSkillDecorator.new(self)
    @decorated_pokemon_skills = decorator_pokemon_skill.decorate_for_index(pokemon.pokemon_skills)
    respond_to do |format|
    if @pokemon_skill.save
        format.html { redirect_to pokemon, notice: 'Skill was successfully added.' }
        format.json { render :show, status: :created, location: pokemon }
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
    if pokemon_params[:pokedex_id].present?

    @pokemon.max_health_point = Pokedex.find(pokemon_params[:pokedex_id]).base_health_point
    @pokemon.current_health_point = Pokedex.find(pokemon_params[:pokedex_id]).base_health_point
    @pokemon.attack = Pokedex.find(pokemon_params[:pokedex_id]).base_attack
    @pokemon.defence = Pokedex.find(pokemon_params[:pokedex_id]).base_defence
    @pokemon.speed = Pokedex.find(pokemon_params[:pokedex_id]).base_speed
    end
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
      if @pokemon.update(update_pokemon_params)
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

    def update_pokemon_params
      params.require(:pokemon).permit(:name, :pokedex_id, :level, :max_health_point, :current_health_point, :attack, :defence, :speed, :current_experience)
    end


end
