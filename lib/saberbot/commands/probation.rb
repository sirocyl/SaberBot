# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # lock a user into a channel for newcomers/punished users. or remove them.
    module Probation
      extend Discordrb::Commands::CommandContainer
      command(:probate, description: 'Add a user to probation. Staff only.', permission_level: 1, min_args: 1) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0].id)

          member.add_role(SaberConfig.server_roles[event.server][SaberConfig.settings['probation_role']])
          SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
            "**Probation Placed:** #{member.mention} || #{member.distinct}\n" \
            "**Responsible Moderator:** #{event.message.author.mention}"
          )
          "Added user to probation."
        else
          'Invalid argument. Please mention a valid user.'
        end
      end

      command(:unprobate, description: 'Remove a user from probation. Staff only', permission_level: 1, min_args: 1) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0].id)

          member.remove_role(SaberConfig.server_roles[event.server][SaberConfig.settings['probation_role']])
          SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
            "**Probation Lifted:** #{member.mention} || #{member.distinct}\n" \
            "**Responsible Moderator:** #{event.message.author.mention}"
          )
          "Removed user from probation."
        else
          'Invalid argument. Please mention a valid user.'
        end
      end

      command(:autoprobate, description: 'Toggles whether new users are automatically added to probation. Admins only.', permission_level: 2) do |event|
        break if event.channel.private?
        SaberConfig.settings['autoprobate'] = !SaberConfig.settings['autoprobate']
        SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
          "**Auto-Probate:** #{Config['autoprobate']}\n" \
          "**Responsible Moderator:** #{event.message.author.mention}"
        )
        "Autoprobate is now: #{SaberConfig.settings['autoprobate']}."
      end
    end
  end
end
