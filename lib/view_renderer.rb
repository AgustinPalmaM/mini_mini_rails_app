require "erb"

class ViewRenderer
  def initialize(template_path, assigns = {})
    @template_path = template_path
    @assigns = assigns
  end

  def render
    template = ERB.new(template_source)
    template.result(view_binding)
  end

  private

  def template_source
    File.read(full_template_path)
  end

  def full_template_path
    File.join(
      Dir.pwd,
      "app",
      "views",
      "#{@template_path}.erb"
    )
  end

  def view_binding
    assigns_to_instance_variables
    binding
  end

  def assigns_to_instance_variables
    @assigns.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end
