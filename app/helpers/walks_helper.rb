module WalksHelper
  def distance_formatted(distance)
    "#{format('%.1f', distance)} mi."
  end

  def duration_formatted(duration)
    "#{format('%.1f', duration)} minutes"
  end

  def speed_formatted(speed)
    "#{format('%.2f', speed * 60)} mph"
  end
end
