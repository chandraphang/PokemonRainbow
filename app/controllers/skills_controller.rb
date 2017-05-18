class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  # GET /skills.json
  def index
    decorator = SkillDecorator.new(self)
    @decorated_skills = decorator.decorate_for_index(Skill.all)
    add_breadcrumb "Home", root_path
    add_breadcrumb "Skill", skills_path
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
    decorator = SkillDecorator.new(self)
    @decorated_skill = decorator.decorate_for_show(Skill.find(params[:id]))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Skill", skills_path
    add_breadcrumb @decorated_skill.name, skill_path
  end

  # GET /skills/new
  def new
    @skill = Skill.new
    add_breadcrumb "Home", root_path
    add_breadcrumb "Skill", skills_path
    add_breadcrumb "New", new_skill_path
  end

  # GET /skills/1/edit
  def edit
    decorator = SkillDecorator.new(self)
    @decorated_skill = decorator.decorate_for_show(Skill.find(params[:id]))
    add_breadcrumb "Home", root_path
    add_breadcrumb "Skill", skills_path
    add_breadcrumb @decorated_skill.name, skill_path
    add_breadcrumb "Edit", edit_skill_path
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(skill_params)

    respond_to do |format|
      if @skill.save
        format.html { redirect_to @skill, notice: 'Skill was successfully created.' }
        format.json { render :show, status: :created, location: @skill }
      else
        format.html { render :new }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to @skill, notice: 'Skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @skill }
      else
        format.html { render :edit }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to skills_url, notice: 'Skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:name, :power, :max_pp, :element_type)

    end
end
