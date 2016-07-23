# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  def SaberBot.parse_time(time_string)
    time_args = time_string.scan(/([0-9]+[a-z]+)/).flatten
    if time_args == [] then return nil end
    seconds = 0
    time_args.each do |time|
      unless time[-1] =~ /[[:alpha:]]/
        return nil
      end

      time[0...-1].split('').each do |char|
        unless char =~ /[[:digit:]]/
          return nil
        end
      end

      case time[-1]
      when 's'
        seconds += time[0...-1].to_i
      when 'm'
        seconds += time[0...-1].to_i * 60
      when 'h'
        seconds += time[0...-1].to_i * 3600
      when 'd'
        seconds += time[0...-1].to_i * 86400
      when 'w'
        seconds += time[0...-1].to_i * 86400 * 7
      else
        return nil
      end
    end
    return seconds
  end
end
