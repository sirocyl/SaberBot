# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  # threaded loops go in here!
  module Loop
    def self.slowmode
      Thread.new do
        loop do
          sleep(1)
          SaberConfig.slowmode_counters.each do |channel|
            SaberConfig.slowmode_counters[channel] = 0
          end
        end
      end
    end
  end
end
