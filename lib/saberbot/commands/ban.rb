#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Ban
      extend Discordrb::Commands::CommandContainer

      command(:ban, description: "Ban a user. Staff only.\nUsage: `!ban <user> <time, ex: 30d.1w.9h.50s> <reason>`", min_args: 1) do |event|
        break if event.channel.private?
        if event.message.author.permission?(:ban_members)
          if event.message.mentions[0]
            args = event.message.content.split(" ")
            member = event.message.mentions[0]
            time = SaberBot.parse_time(args[2])
            reason = args[3..-1].join(" ")
            reason += "." unless reason.end_with?('.')
            details = {sid: event.server.id, mention: member.mention, staff: event.message.author.mention, time: time, start_time: Time.now.utc, stop_time: Time.now.to_i + time, reason: reason}
            member.pm("**You have been banned from #{event.server.name}!**\n**Expiry:** #{ChronicDuration.output(details[:time], :format => :short)} (#{DateTime.strptime(details[:stop_time].to_s, '%s')})\n**Responsible staff member:** #{event.author.mention}\n\n**Reason:** #{reason}")
            event.server.ban(member)
            Server_channels[event.server][Config["modlog_channel"]].send("**Banned:** #{details[:mention]}\n**Time:** #{ChronicDuration.output(details[:time], :format => :short)}\n**Reason:** #{details[:reason]}\n**Responsible Moderator:** #{details[:staff]}")
            Bans[member.id] = details
            nil
          else
            "Invalid argument. Please mention a valid user."
          end
        else
          "You don't have permission to execute command `ban`!"
        end
      end

    end
  end
end
