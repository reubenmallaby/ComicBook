module ComicHelper
  ALLOWED_DIRECTIONS = [:left, :right]

  def link_for_comic(date, text)
    translated = I18n.t(text)

    return content_tag(:div, translated, class: "action no_link #{text}", title: translated) if date.blank?

    link_to(
      translated,
      comic_path(date.year, date.month, date.day),
      class: "action link #{text}",
      title: translated,
      alt: translated
    )
  end

  def link_to_comic_with_day(comic, by_date: true)
    date = comic.publish_date
    day_name = I18n.t("date.day_names")[date.wday]
    text = by_date ? "#{date.day} #{day_name}" : comic.title
    link_to text, manage_comic_path(date.year, date.month, date.day)
  end

  def link_to_comic_edit_path(comic)
    date = comic.publish_date
    link_to "",
            manage_edit_comic_path(date.year, date.month, date.day),
            title: I18n.t("edit"),
            class: "fa-regular fa-pen-to-square"
  end

  def link_to_comic_publish_path(comic)
    date = comic.publish_date
    title = comic.is_published ? I18n.t("hide") : I18n.t("publish")
    icon = comic.is_published ? 'eye-slash' : 'image'
    link_to "",
            manage_publish_comic_path(date.year, date.month, date.day),
            title: title,
            class: "fa-regular fa-#{icon}"
  end

  def link_to_comic_delete_path(comic)
    date = comic.publish_date

    button_to "",
              manage_delete_comic_path(date.year, date.month, date.day),
              method: :delete, form: { data: { turbo_confirm: 'Are you sure?' } },
              title: I18n.t("delete"),
              class: "fa-solid fa-trash"
  end

  def manager_button(form, text: 'default', icon: 'exclamation', dir: :right)
    text = (dir == :right) ?
             "<i class='fa fa-#{icon}' aria-hidden='true'></i> #{I18n.t(text)}".html_safe
             :
             "#{I18n.t(text)} <i class='fa fa-#{icon}' aria-hidden='true'></i>".html_safe
    form.button text,
                class: "button",
                id: "#{text}-button"
  end
end
