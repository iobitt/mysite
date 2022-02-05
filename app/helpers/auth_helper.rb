module AuthHelper
  def field_validation_class(user, field)
    if user.send(field)
      user.errors[field].present? ? 'is-invalid' : 'is-valid'
    else
      ''
    end
  end
end
