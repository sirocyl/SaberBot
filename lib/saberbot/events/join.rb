#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    
    module LogJoin
      extend Discordrb::EventContainer
      member_join do |event|
        Server_channels[event.server][Config["log_channel"]].send("Joined: #{event.user.display_name} || #{event.user.mention} \nAccount creation date: #{event.user.creation_time.getutc.asctime} UTC")
      end
    end

    module AutoProbate
      extend Discordrb::EventContainer
      member_join do |event|
        if Config["autoprobate"] then
          event.server.member(event.user.id).add_role(server_roles[event.server][Config["probation_role"]])
        end
      end
    end

  end
end
