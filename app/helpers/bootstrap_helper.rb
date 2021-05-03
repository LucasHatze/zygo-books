module BootstrapHelper
  def bootstrap_errors_list(resource, field)
    resource = resource_from(resource)
    if has_validation_error?(resource, field)
      content_tag :div, class: 'invalid-feedback d-block' do
        content_tag :ul, class: 'list-unstyled' do
          resource&.errors[field.to_sym].each {|error|
            concat content_tag(:li, error.capitalize)
          }
        end
      end
    end
  end

  def bootstrap_error_class(resource, field)
    has_validation_error?(resource, field) ? 'is-invalid' : ''
  end

  def has_validation_error?(resource, field)
    resource = resource_from(resource)
    resource&.errors[field.to_sym].present?
  end

  def resource_from(resource)
    case
    when resource.instance_of?(ActionView::Helpers::FormBuilder)
      resource.object
    else
      resource
    end
  end
end