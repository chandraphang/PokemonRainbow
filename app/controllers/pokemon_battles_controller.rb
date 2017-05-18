class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :destroy]

  # GET /pokemon_battles
  # GET /pokemon_battles.json
  def index
    decorator = PokemonBattleDecorator.new(self)
    @decorated_pokemon_battles = decorator.decorate_for_index(PokemonBattle.all)
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokemon Battle"
  end

  # GET /pokemon_battles/1
  # GET /pokemon_battles/1.json
  def show
    @errors = {}
    decorator = PokemonBattleDecorator.new(self)
    @decorated_pokemon_battle = decorator.decorate_for_show(PokemonBattle.find(params[:id]))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokemon Battle", pokemon_battles_path
    add_breadcrumb "#{@decorated_pokemon_battle.pokemon1} vs #{@decorated_pokemon_battle.pokemon2}"

  end

  def show_pokemon_battle_log
    @battle_logs = PokemonBattleLog.where(pokemon_battle_id: params[:pokemon_battle_id])
    decorator = PokemonBattleLogDecorator.new(self)
    @decorated_pokemon_battle_log = decorator.decorate_for_index(@battle_logs)
    decorator = PokemonBattleDecorator.new(self)
    @decorated_pokemon_battle = decorator.decorate_for_show(PokemonBattle.find(params[:pokemon_battle_id]))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokemon Battle", pokemon_battles_path
    add_breadcrumb "#{@decorated_pokemon_battle.pokemon1} vs #{@decorated_pokemon_battle.pokemon2}", pokemon_battle_path(params[:pokemon_battle_id])
    add_breadcrumb "Battle Log"
  end

  def attack
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    battle_engine = BattleEngine.new(params[:pokemon_battle_id], params[:pokemon_attacker], params[:pokemon_defender], params[:skill])
    if battle_engine.valid_next_turn?
      battle_engine.next_turn!
      battle_engine.save!
      battle_engine.battle_log!
      respond_to do |format|
        format.html { redirect_to @pokemon_battle }
        format.json { render :show, status: :created, location: @pokemon_battle }
      end
    else
      decorator = PokemonBattleDecorator.new(self)
      @errors = battle_engine.errors
      @decorated_pokemon_battle = decorator.decorate_for_show(@pokemon_battle)
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @errors, status: :unprocessable_entity }
      end
    end

  end

  def surrender
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    battle_engine = BattleEngine.new(params[:pokemon_battle_id], params[:pokemon_defender], params[:pokemon_attacker], params[:skill])
    battle_engine.next_turn!
    battle_engine.save!
    battle_engine.battle_log!
    respond_to do |format|
      format.html { redirect_to @pokemon_battle }
      format.json { render :show, status: :created, location: @pokemon_battle }
    end
  end
  # GET /pokemon_battles/new
  def new
    @pokemon_battle = PokemonBattle.new
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokemon Battle", pokemon_battles_path
    add_breadcrumb "New"
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
