class PokemonSkillsController < ApplicationController
  before_action :set_pokemon_skill, only: [:show, :edit, :update, :destroy]

  # GET /pokemon_skills
  # GET /pokemon_skills.json
  def index
    @pokemon_skills = PokemonSkill.all
  end

  # GET /pokemon_skills/1
  # GET /pokemon_skills/1.json
  def show
  end

  # GET /pokemon_skills/new
  def new
    @pokemon_skill = PokemonSkill.new
  end

  # GET /pokemon_skills/1/edit
  def edit
  end

  # POST /pokemon_skills
  # POST /pokemon_skills.json
  def create
    @pokemon_skill = PokemonSkill.new(pokemon_skill_params)

    respond_to do |format|
      if @pokemon_skill.save
        format.html { redirect_to @pokemon, notice: 'Pokemon skill was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon_skill }
      else
        format.html { render @pokemon }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemon_skills/1
  # PATCH/PUT /pokemon_skills/1.json
  def update
    respond_to do |format|
      if @pokemon_skill.update(pokemon_skill_params)
        format.html { redirect_to @pokemon_skill, notice: 'Pokemon skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokemon_skill }
      else
        format.html { render :edit }
        format.json { render json: @pokemon_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemon_skills/1
  # DELETE /pokemon_skills/1.json
  def destroy
    @pokemon_skill.destroy
    respond_to do |format|
      format.html { redirect_to pokemon_skills_url, notice: 'Pokemon skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_skill
      @pokemon_skill = PokemonSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_skill_params
      params.fetch(:pokemon_skill, {})
    end
end
