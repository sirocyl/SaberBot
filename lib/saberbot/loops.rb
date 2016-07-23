# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Loop
    def Loop.slowmode
      Thread.new {
        loop do
          sleep(1)
          Slowmode_counters.each do |channel, counter|
            Slowmode_counters[channel] = 0
          end
        end
      }
    end
  end
end
