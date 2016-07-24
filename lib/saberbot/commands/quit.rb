# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # bye-bye!
    module Exit
      extend Discordrb::Commands::CommandContainer
      command(:quit, description: 'Disconnect the bot from the server. Admins only.', permission_level: 2) do |event|
        break if event.channel.private?
        event.channel.send('Bye bye!')
        SaberBot.botexit
      end
    end
  end
end
