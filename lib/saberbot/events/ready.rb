# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event

    module PopulateHashes
      extend Discordrb::EventContainer
      ready do |event|
        BotObject.servers.each do |key, server|
          Server_roles[server] = Hash.new
          Server_channels[server] = Hash.new
        end
        BotObject.servers.each do |key, server|
          server.roles.each do |role|
            if role.name == Config["staff_role"]
              BotObject.set_role_permission(role.id, 1)
            elsif role.name == Config["admin_role"]
              BotObject.set_role_permission(role.id, 2)
            end
            Server_roles[server][role.name] = role
          end
          server.channels.each do |channel|
            Server_channels[server][channel.name] = channel
          end
        end
      end
    end

    module SetGameString
      extend Discordrb::EventContainer
      ready do
        BotObject.game = Config["game_string"]
      end
    end

    module SlowmodeLoop
      extend Discordrb::EventContainer
      ready do
        SaberBot::Loop.slowmode
      end
    end

  end
end
