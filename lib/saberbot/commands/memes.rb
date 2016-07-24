# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # Meme commands, for the memers. TODO: Proper custom-command support
    module Memes
      extend Discordrb::Commands::CommandContainer
      command(:lenny, description: 'Memes') do |event|
        '( ͡° ͜ʖ ͡°)' unless event.channel.private?
      end
      command(:permabrocked, description: 'Memes') do |event|
        'http://i.imgur.com/ARsOh3p.jpg' unless event.channel.private?
      end
      command(:rip, description: 'Memes') do |event|
        'Press F to pay respects.' unless event.channel.private?
      end
      command(:s_99, description: 'Memes') do |event|
        '**ALL HAIL BRITANNIA!**' unless event.channel.private?
      end
      command(:xor, description: 'Memes') do |event|
        'http://i.imgur.com/nLKATP6.png' unless event.channel.private?
      end
    end
  end
end
