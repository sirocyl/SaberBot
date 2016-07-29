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

        member = event.server.member(event.message.author.id)
        if SaberConfig.roles[member.id]
          role = event.server.role(SaberConfig.roles[member.id])
          member.add_role(role)
          SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
            "**Role Elevated:** #{member.mention} to #{role.name}"
          )
          "Elevated to #{role.name}. Welcome to the twilight zone!"
        else
          "Error: Your ID isn't saved in the sudo list."
        end
      end

      command(
        :unsudo,
        description: 'De-elevate permissions. Staff only.',
        permission_level: 1
      ) do |event|
        break if event.channel.private?

        member = event.server.member(event.message.author.id)
        if SaberConfig.roles[member.id]
          role = event.server.role(SaberConfig.roles[member.id])
          member.remove_role(role)
          SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
            "**Role De-elevated:** #{member.mention} from #{role.name}"
          )
          "De-elevated from #{role.name}."
        else
          "Error: Your ID isn't saved in the sudo list."
        end
      end
    end
  end
end
