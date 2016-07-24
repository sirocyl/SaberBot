# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # limit a certain number of messages in a channel per second
    module Slowmode
      extend Discordrb::Commands::CommandContainer
      command(
        :slowmode,
        description: 'Set channel into slowmode.' \
        'Arguments: number of messages per second. Staff only.',
        permission_level: 1,
        min_args: 1
      ) do |event, msgs|
        break if event.channel.private?

        if msgs.to_i < 1
          "Invalid amount \"#{msgs}\". Please choose a number of at least 1."
        else
          SaberConfig.slowmode_maxmsgs[event.channel] = msgs.to_i
          SaberConfig.slowmode_counters[event.channel] = 0
          SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
            "**Slowmode Enabled:** #{event.channel.mention}\n" \
            "**Responsible Moderator:** #{event.message.author.mention}"
          )
          "Slowmode enabled. You can only send #{msgs} messages in this channel per second."
        end
      end

      command(
        :slowoff,
        description: 'Disable slowmode on a channel. Staff only.',
        permission_level: 1
      ) do |event|
        break if event.channel.private?

        SaberConfig.slowmode_maxmsgs.delete(event.channel)
        SaberConfig.slowmode_counters.delete(event.channel)
        SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
          "**Slowmode Disabled:** #{event.channel.mention}\n" \
          "**Responsible Moderator:** #{event.message.author.mention}"
        )
        `Slowmode disabled.`
      end
    end
  end
end
