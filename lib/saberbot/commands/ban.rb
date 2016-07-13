#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

require 'date'

module SaberBot
  module Command
    module Ban
      extend Discordrb::Commands::CommandContainer
      command(:ban, description: "Ban a user. Staff only.\nUsage: `!ban <user> <time in hours> <reason>`") do |event|
        if event.message.author.permission?(:ban_members)
          args = event.message.content.split(" ")
          member = event.message.mentions[0]
          time = args[2].to_i
          reason = args[3..-1].join(" ")
          reason += "." unless reason.end_with?('.')
          details = {sid: event.server.id, mention: member.mention, staff: event.message.author.mention, time: time, start_time: Time.now.utc, stop_time: Time.now.to_i + time * 3600, reason: reason}
          member.pm("**You have been banned from #{event.server.name}!**\n**Expiry:** #{time} hours (#{DateTime.strptime(details[:stop_time].to_s, '%s')})\n**Responsible staff member:** #{event.author.mention}\n\n**Reason:** #{reason}")
          event.server.ban(member)
          Server_channels[event.server][Config["banlog_channel"]].send("**Banned:** #{details[:mention]}\n**Time:** #{details[:time]} hours\n**Reason:** #{details[:reason]}\n**Responsible Moderator:** #{details[:staff]}")
          Bans[member.id] = details
          nil
        else
          "You don't have permission to execute command `ban`!"
        end
      end 
    end
  end
end
