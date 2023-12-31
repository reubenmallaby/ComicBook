module DeviseHelper
  def devise_link_text(icon, text)
    "<i class='#{icon}' aria-hidden='true'></i> #{I18n.t("devise.links."+text)}".html_safe
  end
  def devise_link_to_sign_in(resource_name, controller_name)
    link_to devise_link_text("fa-solid fa-right-to-bracket", "sign_in"), new_session_path(resource_name), class: "devise-link"
  end

  def devise_link_to_sign_up(resource_name)
    link_to devise_link_text("fa fa-hand-point-up", "sign_up"), new_registration_path(resource_name), class: "devise-link"
  end

  def devise_link_to_forgot_password(resource_name)
    link_to devise_link_text("fa fa-hand", "forgot"), new_password_path(resource_name), class: "devise-link"
  end

  def devise_link_to_confirmation_instructions(resource_name)
    link_to devise_link_text("fa fa-circle-question", "no_confirmation"), new_confirmation_path(resource_name), class: "devise-link"
  end

  def devise_link_to_unlock_instructions(resource_name)
    link_to devise_link_text("fa fa-circle-question", "no_instructions"), new_unlock_path(resource_name), class: "devise-link"
  end



end
