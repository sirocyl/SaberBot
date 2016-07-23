# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Sudo
      extend Discordrb::Commands::CommandContainer

      command(:sudo, description: "Elevate permissions. Staff only.", permission_level: 1) do |event|
        break if event.channel.private?
        if Roles[event.message.author.id]
          role = event.server.role(Roles[event.message.author.id])
          event.message.author.add_role(role)
          "Elevated #{event.message.author.mention} to #{role.name}. Welcome to the twilight zone!"
        else
          "Error: Your UID isn't saved in the sudo list! You should report this to an admin."
        end
      end

      command(:unsudo, description: "Deelevate permissions. Staff only.", permission_level: 1) do |event|
        break if event.channel.private?
        if Roles[event.message.author.id]
          role = event.server.role(Roles[event.message.author.id])
          event.message.author.remove_role(role)
          "De-elevated #{event.message.author.mention} from #{role.name}."
        else
          "Error: Your UID isn't saved in the sudo list! You should report this to an admin."
        end
      end

    end
  end
end
