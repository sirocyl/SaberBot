# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Parse time strings, such as "12w5d3h47m5s"
module SaberBot
  def self.parse_time(time_string)
    time_args = time_string.scan(/([0-9]+[a-z]+)/).flatten
    return nil if time_args == []

    seconds = 0
    time_args.each do |time|
      return nil unless time[-1] =~ /[[:alpha:]]/

      time[0...-1].split('').each do |char|
        return nil unless char =~ /[[:digit:]]/
      end

      case time[-1]
      when 's'
        seconds += time[0...-1].to_i
      when 'm'
        seconds += time[0...-1].to_i * 60
      when 'h'
        seconds += time[0...-1].to_i * 3_600
      when 'd'
        seconds += time[0...-1].to_i * 86_400
      when 'w'
        seconds += time[0...-1].to_i * 86_400 * 7
      else
        return nil
      end
    end
    seconds
  end
end
