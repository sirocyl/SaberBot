#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Logs
      extend Discordrb::Commands::CommandContainer
      command(:logs, description: "Posts the server logs URL") do
        "You can check the logs here: #{Config["log_url"]}"
      end
    end
  end
end

# !logs - Posts a link to the server chat logs
