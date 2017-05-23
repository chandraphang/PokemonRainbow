class TrainersController < ApplicationController
  before_action :set_trainer, only: [:show, :edit, :update, :destroy]

  # GET /trainers
  # GET /trainers.json
  def index
    decorator = TrainerDecorator.new(self)
    @decorated_trainers = decorator.decorate_for_index(Trainer.all.order(:id))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Trainer"
  end

  # GET /trainers/1
  # GET /trainers/1.json
  def show
    trainer = Trainer.find(params[:id])
    decorator = TrainerDecorator.new(self)
    @decorated_trainer = decorator.decorate_for_show(trainer)
    decorator_pokemon_trainers = PokemonTrainerDecorator.new(self)
    @decorated_pokemon_trainers = decorator_pokemon_trainers.decorate_for_index(trainer.pokemon)
    @pokemon_trainer = PokemonTrainer.new
    add_breadcrumb "Home", root_path
    add_breadcrumb "Trainer", trainers_path
    add_breadcrumb @decorated_trainer.name

    @top_used_pokemon = PokemonRainbowStatistic.generate_top_used_pokemon_trainer(trainer.id)
    @top_used_skill = PokemonRainbowStatistic.generate_top_used_skill(trainer.id)
  end

  def create_pokemon_trainer
    trainer = Trainer.find(params[:trainer_id])
    @pokemon_trainer = PokemonTrainer.new
    @pokemon_trainer.pokemon_id =  params[:pokemon_trainer][:pokemon_id]
    @pokemon_trainer.trainer_id = params[:trainer_id]
    decorator = TrainerDecorator.new(self)
    @decorated_trainer = decorator.decorate_for_show(Trainer.find(params[:trainer_id]))

    decorator_pokemon_trainer = PokemonTrainerDecorator.new(self)
    @decorated_pokemon_trainers = decorator_pokemon_trainer.decorate_for_index(trainer.pokemon)
    respond_to do |format|
      if @pokemon_trainer.save
        format.html { redirect_to trainer, notice: 'Pokemon was successfully added.' }
        format.json { render :show, status: :created, location: pokemon }
      else
        format.html { render :show }
        format.json { render json: @pokemon_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_pokemon_trainer
    @trainer = Trainer.find(params[:trainer_id])
    @pokemon_trainer = PokemonTrainer.where(trainer_id: params[:trainer_id]).where(:pokemon_id => params[:pokemon_trainer_id])
    @pokemon_trainer.destroy_all
    respond_to do |format|
      format.html { redirect_to @trainer, notice: 'Pokemon Trainer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  # GET /trainers/new
  def new
    @trainer = Trainer.new
  end

  # GET /trainers/1/edit
  def edit
  end

  # POST /trainers
  # POST /trainers.json
  def create
    @trainer = Trainer.new(trainer_params)

    respond_to do |format|
      if @trainer.save
        format.html { redirect_to @trainer, notice: 'Trainer was successfully created.' }
        format.json { render :show, status: :created, location: @trainer }
      else
        format.html { render :new }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainers/1
  # PATCH/PUT /trainers/1.json
  def update
    respond_to do |format|
      if @trainer.update(trainer_params)
        format.html { redirect_to @trainer, notice: 'Trainer was successfully updated.' }
        format.json { render :show, status: :ok, location: @trainer }
      else
        format.html { render :edit }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainers/1
  # DELETE /trainers/1.json
  def destroy
    @trainer.destroy
    respond_to do |format|
      format.html { redirect_to trainers_url, notice: 'Trainer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trainer
      @trainer = Trainer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trainer_params
      params.require(:trainer).permit(:name, :email, :password)
    end
end
