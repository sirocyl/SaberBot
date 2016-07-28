# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Parse time strings, such as "12w5d3h47m"
module SaberBot
  TIMEUNITS = {
    'm' => 60,
    'h' => 3_600,
    'd' => 86_400,
    'w' => 604_800
  }.freeze

  def self.valid_time?(time_string)
    time_string =~ /\A([0-9]+[mhdw])+\Z/
  end

  def self.parse_time(time_string)
    return nil unless valid_time?(time_string)
    time_args = time_string.scan(/([0-9]+[mhdw])/).flatten

    seconds = 0
    time_args.each do |time|
      time[0...-1].split('').each do |char|
        return nil unless char =~ /[[:digit:]]/
      end

      seconds += time[0...-1].to_i * TIMEUNITS[time[-1]]
    end
    seconds
  end
end
