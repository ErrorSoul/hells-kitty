
module GlyphiconHelper

  ICONS = %w(
   edit trash arrow-left ok plus search user print alert send
   sort file
  ).freeze

  ICONS.each do |icon|
    define_method "icon_#{icon.underscore}" do
      content_tag :span, nil, class: icon_class(icon)
    end
  end

  def icon_caret
    content_tag :span, nil, class: 'caret'
  end

  private

  def icon_class(icon)
    "glyphicon glyphicon-#{icon}"
  end

end
