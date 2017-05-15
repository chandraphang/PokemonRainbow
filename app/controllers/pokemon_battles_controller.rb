class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :edit, :update, :destroy]

  # GET /pokemon_battles
  # GET /pokemon_battles.json
  def index
    decorator = PokemonBattleDecorator.new(self)
    @decorated_pokemon_battles = decorator.decorate_for_index(PokemonBattle.all)
  end

  # GET /pokemon_battles/1
  # GET /pokemon_battles/1.json
  def show
    decorator = PokemonBattleDecorator.new(self)
    @errors = {}
    @decorated_pokemon_battle = decorator.decorate_for_show(PokemonBattle.find(params[:id]))
  end

  def attack
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    if params[:skill].present?
      pokemon_attacker = Pokemon.find(params[:pokemon_attacker])
      pokemon_defender = Pokemon.find(params[:pokemon_defender])
      skill = Skill.where(name: params[:skill]).first
      if pokemon_defender.current_health_point > 0
        attack = PokemonBattleCalculator.calculate_damage(pokemon_attacker, pokemon_defender, skill)
        remaining_health_point = pokemon_defender.current_health_point - attack

        if remaining_health_point <= 0
          pokemon_defender.current_health_point = 0
          @pokemon_battle.pokemon_winner_id = pokemon_attacker.id
          @pokemon_battle.pokemon_loser_id = pokemon_defender.id
          @pokemon_battle.state = "Finish"
        else
          pokemon_defender.current_health_point -= attack
        end

        pokemon_skill = PokemonSkill.where(pokemon_id: params[:pokemon_attacker], skill_id: skill.id).first

        if pokemon_skill.current_pp > 0
          pokemon_skill.current_pp -= 1
          @pokemon_battle.current_turn += 1
          pokemon_defender.save
          pokemon_skill.save

          respond_to do |format|
            if @pokemon_battle.save
              format.html { redirect_to @pokemon_battle }
              format.json { render :show, status: :created, location: @pokemon_battle }
            else
              format.html { render :show }
              format.json { render json: @pokemon_battle.errors, status: :unprocessable_entity }
            end
          end
        else
          @errors = { skill: 'Current PP must be greater than 0.'}
          decorator = PokemonBattleDecorator.new(self)
          @decorated_pokemon_battle = decorator.decorate_for_show(@pokemon_battle)

          respond_to do |format|
            format.html { render :show }
            format.json { render json: @errors, status: :unprocessable_entity }
          end
        end
      end
    else
      @errors = { skill: 'Pokemon Skill must exist.'}
      decorator = PokemonBattleDecorator.new(self)
      @decorated_pokemon_battle = decorator.decorate_for_show(@pokemon_battle)

      respond_to do |format|
        format.html { render :show }
        format.json { render json: @errors, status: :unprocessable_entity }
      end
    end


  end

  def surrender
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    pokemon_attacker = Pokemon.find(params[:pokemon_attacker])
    pokemon_defender = Pokemon.find(params[:pokemon_defender])
    @pokemon_battle.pokemon_loser_id = pokemon_attacker.id
    @pokemon_battle.pokemon_winner_id = pokemon_defender.id
    @pokemon_battle.state = "Finish"

    respond_to do |format|
            if @pokemon_battle.save
              format.html { redirect_to @pokemon_battle, notice: 'Pokemon battle was successfully created.' }
              format.json { render :show, status: :created, location: @pokemon_battle }
            else
              format.html { render :new }
              format.json { render json: @pokemon_battle.errors, status: :unprocessable_entity }
            end
          end
  end
  # GET /pokemon_battles/new
  def new
    @pokemon_battle = PokemonBattle.new
  end

  # GET /pokemon_battles/1/edit
  def edit
  end

  # POST /pokemon_battles
  # POST /pokemon_battles.json
  def create
    @pokemon_battle = PokemonBattle.new
    if params[:pokemon_battle][:pokemon1_id].present?
      @pokemon_battle.pokemon1_id = params[:pokemon_battle][:pokemon1_id].to_i
      @pokemon_battle.pokemon1_max_health_point = Pokemon.find(params[:pokemon_battle][:pokemon1_id]).max_health_point
    end
    if params[:pokemon_battle][:pokemon2_id].present?
    @pokemon_battle.pokemon2_id = params[:pokemon_battle][:pokemon2_id].to_i
    @pokemon_battle.pokemon2_max_health_point = Pokemon.find(params[:pokemon_battle][:pokemon2_id]).max_health_point
    end


    @pokemon_battle.current_turn = 1
    @pokemon_battle.state = "On Going"
    @pokemon_battle.pokemon_winner_id = nil
    @pokemon_battle.pokemon_loser_id = nil
    @pokemon_battle.experience_gain = 0

    respond_to do |format|
      if @pokemon_battle.save
        format.html { redirect_to @pokemon_battle, notice: 'Pokemon battle was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon_battle }
      else
        format.html { render :new }
        format.json { render json: @pokemon_battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemon_battles/1
  # PATCH/PUT /pokemon_battles/1.json
  def update
    respond_to do |format|
      if @pokemon_battle.update(pokemon_battle_params)
        format.html { redirect_to @pokemon_battle, notice: 'Pokemon battle was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokemon_battle }
      else
        format.html { render :edit }
        format.json { render json: @pokemon_battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemon_battles/1
  # DELETE /pokemon_battles/1.json
  def destroy
    @pokemon_battle.destroy
    respond_to do |format|
      format.html { redirect_to pokemon_battles_url, notice: 'Pokemon battle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_battle
      @pokemon_battle = PokemonBattle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_battle_params
      params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id)
    end
  end
