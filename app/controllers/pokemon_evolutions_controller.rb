class PokemonEvolutionsController < ApplicationController
  before_action :set_pokemon_evolution, only: [:show, :edit, :update, :destroy]

  # GET /pokemon_evolutions
  # GET /pokemon_evolutions.json
  def index
    @pokemon_evolutions = PokemonEvolution.all
  end

  # GET /pokemon_evolutions/1
  # GET /pokemon_evolutions/1.json
  def show
  end

  # GET /pokemon_evolutions/new
  def new
    @pokemon_evolution = PokemonEvolution.new
  end

  # GET /pokemon_evolutions/1/edit
  def edit
  end

  # POST /pokemon_evolutions
  # POST /pokemon_evolutions.json
  def create
    @pokemon_evolution = PokemonEvolution.new(pokemon_evolution_params)

    respond_to do |format|
      if @pokemon_evolution.save
        format.html { redirect_to @pokemon_evolution, notice: 'Pokemon evolution was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon_evolution }
      else
        format.html { render :new }
        format.json { render json: @pokemon_evolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemon_evolutions/1
  # PATCH/PUT /pokemon_evolutions/1.json
  def update
    respond_to do |format|
      if @pokemon_evolution.update(pokemon_evolution_params)
        format.html { redirect_to @pokemon_evolution, notice: 'Pokemon evolution was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokemon_evolution }
      else
        format.html { render :edit }
        format.json { render json: @pokemon_evolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemon_evolutions/1
  # DELETE /pokemon_evolutions/1.json
  def destroy
    @pokemon_evolution.destroy
    respond_to do |format|
      format.html { redirect_to pokemon_evolutions_url, notice: 'Pokemon evolution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_evolution
      @pokemon_evolution = PokemonEvolution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_evolution_params
      params.fetch(:pokemon_evolution, {})
    end
end
