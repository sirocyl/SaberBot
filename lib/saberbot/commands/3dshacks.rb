#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module RedditCommands
      extend Discordrb::Commands::CommandContainer
      command(:guide, description: "3DS Help") do
        "The recommended guide for setting up a hacked 3DS is here: <https://github.com/Plailect/Guide/wiki>"
      end
      command(:builds, description: "3DS Help") do
        "astronautlevel's Luma3DS commit builds can be found here: <https://astronautlevel2.github.io/Luma3DS>"
      end
      command(:star, description: "3DS Help") do
        "The latest release of StarUpdater, an on-3DS homebrew app to update your Luma3DS installation, can be found here: <https://github.com/astronautlevel2/StarUpdater/releases/latest>"
      end
    end
  end
end
