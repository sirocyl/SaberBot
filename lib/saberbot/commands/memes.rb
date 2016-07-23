# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Memes
      extend Discordrb::Commands::CommandContainer
      command(:lenny, description: "Memes") do |event|
        break if event.channel.private?
        "( ͡° ͜ʖ ͡°)"
      end
      command(:permabrocked, description: "Memes") do |event|
        break if event.channel.private?
        "http://i.imgur.com/ARsOh3p.jpg"
      end
      command(:rip, description: "Memes") do |event|
        break if event.channel.private?
        "Press F to pay respects."
      end
      command(:s_99, description: "Memes") do |event|
        break if event.channel.private?
        "**ALL HAIL BRITANNIA!**"
      end
      command(:xor, description: "Memes") do |event|
        break if event.channel.private?
        "http://i.imgur.com/nLKATP6.png"
      end
    end
  end
end
