class SkillDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :name,
    :power,
    :max_pp,
    :element_type,
    :link_to_show,
    :link_to_edit,
    :link_to_remove
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(skills)
    results = []
    skills.each do |skill|
      results << generate_decorator_result(skill)
    end
    results
  end

  def decorate_for_show(skill)
    result = generate_decorator_result(skill)
    result
  end

  private

  def generate_decorator_result(skill)
    result = DecoratorResult.new
    result.name = skill.name
    result.power = skill.power
    result.max_pp = skill.max_pp
    result.element_type = skill.element_type
    result.link_to_show = set_link_to_show(skill)
    result.link_to_edit = set_link_to_edit(skill)
    result.link_to_remove = set_link_to_remove(skill)

    result
  end

  def set_link_to_show(skill)
    @context.helpers.link_to skill.name, skill
  end

  def set_link_to_edit(skill)
    @context.helpers.button_to 'Edit', edit_skill_path(skill), method: 'get', class: 'btn btn-warning btn-remove', id: 'custom-btn'
  end

  def set_link_to_remove(skill)
    @context.helpers.button_to 'Remove', skill, :method => 'delete', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-danger btn-remove', id: 'custom-btn'
  end
end