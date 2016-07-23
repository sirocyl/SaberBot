# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Logs
      extend Discordrb::Commands::CommandContainer
      command(:logs, description: "Posts the server logs URL") do |event|
        break if event.channel.private?
        "You can check the logs here: #{Config["log_url"]}"
      end
    end
  end
end
