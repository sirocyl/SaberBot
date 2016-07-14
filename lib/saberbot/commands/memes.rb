#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Memes
      extend Discordrb::Commands::CommandContainer
      command(:lenny, description: "Memes") do
        "( ͡° ͜ʖ ͡°)"
      end
      command(:permabrocked, description: "Memes") do
        "http://i.imgur.com/ARsOh3p.jpg"
      end
      command(:rip, description: "Memes") do
        "Press F to pay respects."
      end
      command(:s_99, description: "Memes") do
        "**ALL HAIL BRITANNIA!**"
      end
      command(:xor, description: "Memes") do
        "http://i.imgur.com/nLKATP6.png"
      end
    end
  end
end
