class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:show, :destroy]

  # GET /pokemon_battles
  # GET /pokemon_battles.json
  def index
    decorator = PokemonBattleDecorator.new(self)
    @decorated_pokemon_battles = decorator.decorate_for_index(PokemonBattle.all.order(id: :desc))
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
    @battle_logs = PokemonBattleLog.where(pokemon_battle_id: params[:pokemon_battle_id]).order(:id)
    decorator = PokemonBattleLogDecorator.new(self)
    @decorated_pokemon_battle_log = decorator.decorate_for_index(@battle_logs)
    decorator = PokemonBattleDecorator.new(self)
    @decorated_pokemon_battle = decorator.decorate_for_show(PokemonBattle.find(params[:pokemon_battle_id]))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokemon Battle", pokemon_battles_path
    add_breadcrumb "#{@decorated_pokemon_battle.pokemon1} vs #{@decorated_pokemon_battle.pokemon2}", pokemon_battle_path(params[:pokemon_battle_id])
    add_breadcrumb "Battle Log"
  end

  def check_evolution
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    @pokemon_winner = Pokemon.find(@pokemon_battle.pokemon_winner_id)
  end

  def do_evolution
    pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    @pokemon_evolve = Pokemon.find(pokemon_battle.pokemon_winner_id)
    PokemonEvolutionEngine.do_evolution!(@pokemon_evolve)
    if PokemonEvolutionEngine.add_skill!(@pokemon_evolve)
      respond_to do |format|
          format.html { redirect_to pokemon_battle_evolve_done_path }
          format.json { render :show, status: :created, location: @pokemon_battle }
      end
    else
      respond_to do |format|
          format.html { redirect_to pokemon_battle_replace_skill_path }
          format.json { render :show, status: :created, location: @pokemon_battle }
      end
    end
  end

  def evolve_done
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    @pokemon_evolve = Pokemon.find(@pokemon_battle.pokemon_winner_id)
  end

  def replace_skill
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    @pokemon_evolve = Pokemon.find(@pokemon_battle.pokemon_winner_id)

    existing_pokemon_skill = @pokemon_evolve.pokemon_skills
    @new_skill = existing_pokemon_skill.first
    while existing_pokemon_skill.include?(@new_skill)
      @new_skill = Skill.where(element_type: @pokemon_evolve.pokedex.element_type).sample
    end
    @new_skill
  end

  def remove_and_add_random_skill
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    @pokemon_evolve = Pokemon.find(@pokemon_battle.pokemon_winner_id)
    @new_skill = Skill.find(params[:new_skill])
  end

  def do_remove_and_add_random_skill
    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    @pokemon_evolve = Pokemon.find(@pokemon_battle.pokemon_winner_id)
    old_skill = Skill.find_by(name: params[:old_skill])
    new_skill = Skill.find(params[:new_skill])
    remove_and_add_random_skill = PokemonEvolutionEngine.remove_and_add_skill(@pokemon_evolve, old_skill, new_skill)
    respond_to do |format|
          format.html { redirect_to pokemon_battle_evolve_done_path }
    end
  end

  def attack

    @pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
    battle_engine = BattleEngine.new(params[:pokemon_battle_id], params[:pokemon_attacker], params[:pokemon_defender], params[:skill])
    if battle_engine.valid_next_turn?
      battle_engine.next_turn!
      battle_engine.save!
      battle_engine.battle_log!
      @pokemon_battle.reload
      if @pokemon_battle.battle_type == 'Battle With AI' && @pokemon_battle.state == 'On Going'
        battle_engine.ai_next_turn!
        battle_engine.save!
        battle_engine.ai_battle_log!

        respond_to do |format|
          format.html { redirect_to @pokemon_battle }
          format.json { render :show, status: :created, location: @pokemon_battle }
        end
      elsif @pokemon_battle.state == 'Finish'
        pokemon_attacker = Pokemon.find(params[:pokemon_attacker])
        if PokemonEvolutionEngine.check_evolution?(pokemon_attacker)
          respond_to do |format|
          format.html { redirect_to pokemon_battle_check_evolution_path }
          format.json { render :show, status: :created, location: @pokemon_battle }
          end
        else
          respond_to do |format|
          format.html { redirect_to @pokemon_battle }
          format.json { render :show, status: :created, location: @pokemon_battle }
          end
        end
      else
        respond_to do |format|
        format.html { redirect_to @pokemon_battle }
        format.json { render :show, status: :created, location: @pokemon_battle }
        end
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
    battle_engine = BattleEngine.new(params[:pokemon_battle_id], params[:pokemon_attacker], params[:pokemon_defender], params[:skill])
    battle_engine.next_turn!
    battle_engine.save!
    battle_engine.battle_log!
    if PokemonEvolutionEngine.check_evolution?(Pokemon.find(params[:pokemon_defender]))
      respond_to do |format|
        format.html { redirect_to pokemon_battle_check_evolution_path }
        format.json { render :show, status: :created, location: @pokemon_battle }
      end
    else
      respond_to do |format|
        format.html { redirect_to @pokemon_battle }
        format.json { render :show, status: :created, location: @pokemon_battle }
      end
    end

  end

  def new
    @pokemon_battle = PokemonBattle.new
    add_breadcrumb "Home", root_path
    add_breadcrumb "Pokemon Battle", pokemon_battles_path
    add_breadcrumb "New"
  end

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
    @pokemon_battle.battle_type = 'Manual Battle'
      if @pokemon_battle.save
        if params[:commit] == 'Battle With AI'
          @pokemon_battle.battle_type = 'Battle With AI'
          @pokemon_battle.save
          respond_to do |format|
            format.html { redirect_to @pokemon_battle, notice: 'Pokemon battle was successfully created.' }
            format.json { render :show, status: :created, location: @pokemon_battle }
          end
        elsif params[:commit] == 'Auto Battle'
          @pokemon_battle.battle_type = 'Auto Battle'
          @pokemon_battle.save
          auto_battle_engine = AutoBattleEngine.new(@pokemon_battle)
          auto_battle_engine.execute!
          pokemon_winner = Pokemon.find(@pokemon_battle.pokemon_winner_id)
          if PokemonEvolutionEngine.check_evolution?(pokemon_winner)
            respond_to do |format|
              format.html { redirect_to pokemon_battle_check_evolution_path(@pokemon_battle) }
              format.json { render :show, status: :created, location: @pokemon_battle }
            end
          else
            respond_to do |format|
              format.html { redirect_to @pokemon_battle }
              format.json { render :show, status: :created, location: @pokemon_battle }
            end
          end
        else
          respond_to do |format|
            format.html { redirect_to @pokemon_battle, notice: 'Pokemon battle was successfully created.' }
            format.json { render :show, status: :created, location: @pokemon_battle }
          end
        end
      else
        respond_to do |format|
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
