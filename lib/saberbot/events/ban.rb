#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    module LogBan
      extend Discordrb::EventContainer
      user_ban do |event|
        Server_channels[event.server][Config["banlog_channel"]].send("Banned: #{event.user.mention}")
      end
      user_unban do |event|
        Server_channels[event.server][Config["banlog_channel"]].send("Unbanned: #{event.user.mention}")
      end
    end
  end
end
