# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # let staff users be normal users most of the time
    module Sudo
      extend Discordrb::Commands::CommandContainer
      command(
        :sudo,
        description: 'Elevate permissions. Staff only.',
        permission_level: 1
      ) do |event|
        break if event.channel.private?

        if SaberConfig.roles[event.message.author.id]
          role = event.server.role(SaberConfig.roles[event.message.author.id])
          event.message.author.add_role(role)
          "Elevated #{event.message.author.mention} to #{role.name}. Welcome to the twilight zone!"
        else
          "Error: Your ID isn't saved in the sudo list!"
        end
      end

      command(
        :unsudo,
        description: 'De-elevate permissions. Staff only.',
        permission_level: 1
      ) do |event|
        break if event.channel.private?

        if SaberConfig.roles[event.message.author.id]
          role = event.server.role(SaberConfig.roles[event.message.author.id])
          event.message.author.remove_role(role)
          "De-elevated #{event.message.author.mention} from #{role.name}."
        else
          "Error: Your ID isn't saved in the sudo list!"
        end
      end
    end
  end
end
