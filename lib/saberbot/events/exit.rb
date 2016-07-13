#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event

    module LogExit
      extend Discordrb::EventContainer
      member_leave do |event|
        Server_channels[event.server][Config["log_channel"]].send("Left: #{event.user.mention}")
      end
    end
    
  end
end
