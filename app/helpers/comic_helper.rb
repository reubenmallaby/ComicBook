module ComicHelper
  include ActsAsTaggableOn::TagsHelper

  ALLOWED_DIRECTIONS = [:left, :right]

  def link_for_comic(comic, text)
    translated = I18n.t(text)

    return content_tag(:div, translated, class: "action no_link #{text}", title: translated) if comic.blank?

    date = comic.publish_date

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
    text = by_date ?
             "<div class='day'>#{date.day}</div><div class='day_name'>#{day_name}</div>".html_safe : comic.title
    link_to text,
            manage_comic_path(date.year, date.month, date.day),
            class: comic.is_published? ? 'published' : 'not-published',
            title:     comic.is_published? ? 'Published' : 'Not published'
  end

  def link_to_comic_edit_path(comic)
    date = comic.publish_date
    link_to "",
            edit_manage_comic_path(comic),
            title: I18n.t("edit"),
            class: "fa-regular fa-pen-to-square"
  end

  def published_icon(comic)
    status_class = comic.is_published? ? 'xmark' : 'check'
    text = "<i class='fa-regular fa-calendar-#{status_class}' aria-hidden='true'></i>"
    text.html_safe
  end

  def link_to_comic_publish_path(comic)
    title = comic.is_published ? I18n.t("hide") : I18n.t("publish")
    icon = comic.is_published ? 'check' : 'xmark'
    button_to "",
            manage_publish_comic_path(comic),
            method: :patch,
            title: title,
            class: "fa-regular fa-calendar-#{icon}"
  end

  def link_to_comic_delete_path(comic)
    button_to "",
              manage_comics_path(comic),
              method: :delete,
              form: { data: { turbo_confirm: 'Are you sure?' } },
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
