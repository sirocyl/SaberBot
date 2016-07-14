#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Kick
      extend Discordrb::Commands::CommandContainer

      command(:kick, description: "Kick a user. Staff only.\nUsage: `!kick <user> <reason>`", min_args: 1) do |event|
        break if event.channel.private?
        if event.message.author.permission?(:kick_members)
          if event.message.mentions[0]
            args = event.message.content.split(" ")
            member = event.message.mentions[0]
            reason = args[2..-1].join(" ")
            reason += "." unless reason.end_with?('.')
            details = {sid: event.server.id, mention: member.mention, distinct: member.distinct, staff: event.message.author.mention, reason: reason}
            member.pm("**You have been kicked from #{event.server.name}!**\n**Responsible staff member:** #{event.message.author.mention}\n\n**Reason:** #{reason}")
            event.server.kick(member)
            Server_channels[event.server][Config["modlog_channel"]].send("**Kicked:** #{details[:mention]} || #{details[:distinct]}\n**Reason:** #{details[:reason]}\n**Responsible Moderator:** #{details[:staff]}")
            nil
          else
            "Invalid argument. Please mention a valid user."
          end
        else
          "You don't have permission to execute command `kick`!"
        end
      end

    end
  end
end
