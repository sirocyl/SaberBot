# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Slowmode
      extend Discordrb::Commands::CommandContainer

      command(:slowmode, description: "Set channel into slowmode. Arguments: number of messages per second. Staff only.", permission_level: 1, min_args: 1) do |event, msgs|
        break if event.channel.private?
        if msgs.to_i < 1 then
          "Invalid amount \"#{msgs}\". Please choose a number of at least 1."
        else
          Slowmode_maxmsgs[event.channel] = msgs.to_i
          Slowmode_counters[event.channel] = 0
          Server_channels[event.server][Config["modlog_channel"]].send("**Slowmode Enabled:** #{event.channel.mention}\n**Responsible Moderator:** #{event.message.author.mention}")
          "Slowmode enabled. You can only send #{msgs} messages in this channel per second."
        end
      end

      command(:slowoff, description: "Disable slowmode on a channel. Staff only.", permission_level: 1) do |event|
        break if event.channel.private?
        Slowmode_maxmsgs.delete(event.channel)
        Slowmode_counters.delete(event.channel)
        Server_channels[event.server][Config["modlog_channel"]].send("**Slowmode Disabled:** #{event.channel.mention}\n**Responsible Moderator:** #{event.message.author.mention}")
        "Slowmode disabled."
      end

    end
  end
end
