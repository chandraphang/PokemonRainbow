class TrainerDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :id,
    :name,
    :password,
    :email,
    :link_to_show,
    :link_to_edit,
    :link_to_remove,
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(trainers)
    results = []
    trainers.each do |trainer|
      results << generate_decorator_result(trainer)
    end
    results
  end

  def decorate_for_show(trainer)
    result = generate_decorator_result(trainer)
    result
  end

  private

  def generate_decorator_result(trainer)
    result = DecoratorResult.new
    result.id = trainer.id
    result.name = trainer.name
    result.password = trainer.password
    result.email = trainer.email
    result.link_to_show = set_link_to_show(trainer)
    result.link_to_edit = set_link_to_edit(trainer)
    result.link_to_remove = set_link_to_remove(trainer)

    result
  end

  def set_link_to_show(trainer)
    @context.helpers.link_to trainer.name, trainer
  end

  def set_link_to_edit(trainer)
    @context.helpers.button_to 'Edit', edit_trainer_path(trainer), method: 'get', class: 'btn btn-warning btn-remove', id: 'custom-btn'
  end

  def set_link_to_remove(trainer)
    @context.helpers.button_to 'Remove', trainer, :method => 'delete', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-danger btn-remove', id: 'custom-btn'
  end
end