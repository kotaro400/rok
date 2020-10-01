module CommandersHelper

  def commander_icon(commander)
    case commander&.rarity
    when "レジェンド"
      image_tag "commander_#{commander.id}_icon", class: "legend-icon"
    when "エピック"
      image_tag "commander_#{commander.id}_icon", class: "epic-icon"
    else
      image_tag "commander"
    end
  end

end
