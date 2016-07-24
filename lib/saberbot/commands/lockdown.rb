# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # !lockdown and !unlockdown allow staff to be heard and control bad situations
    module Lockdown
      extend Discordrb::Commands::CommandContainer
      command(
        :lockdown,
        description: 'Disable channel send permissions to normal users. Staff only.',
        permission_level: 1
      ) do |event|
        break if event.channel.private?

        lockdown = Discordrb::Permissions.new
        lockdown.can_send_messages = true
        event.channel.define_overwrite(SaberConfig.server_roles[event.server][SaberConfig.settings['everyone_role']], 0, lockdown)

        SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
          "**Lockdown Enabled:** #{event.channel.mention}\n" \
          "**Responsible Moderator:** #{event.message.author.mention}"
        )
        'This channel is now in lockdown. Only staff can send messages.'
      end

      command(
        :unlockdown,
        description: 'Enable channel send permissions to normal users. Staff only.',
        permission_level: 1
      ) do |event|
        break if event.channel.private?

        lockdown = Discordrb::Permissions.new
        lockdown.can_send_messages = false
        event.channel.define_overwrite(SaberConfig.server_roles[event.server][SaberConfig.settings['everyone_role']], lockdown, 0)
        SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
          "**Lockdown Lifted:** #{event.channel.mention}\n" \
          "**Responsible Moderator:** #{event.message.author.mention}"
        )
        'This channel is no longer in lockdown.'
      end
    end
  end
end
