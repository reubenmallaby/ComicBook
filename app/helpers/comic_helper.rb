module ComicHelper
  def link_for_comic date, text
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
end
