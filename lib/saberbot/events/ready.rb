# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    # populate our hashes with info when the bot connects!
    module PopulateHashes
      extend Discordrb::EventContainer
      ready do
        BotObject.servers.each do |_key, server|
          SaberConfig.server_roles[server] = {}
          SaberConfig.server_channels[server] = {}
        end
        BotObject.servers.each do |_key, server|
          server.roles.each do |role|
            if role.name == SaberConfig.settings['staff_role']
              BotObject.set_role_permission(role.id, 1)
            elsif role.name == SaberConfig.settings['admin_role']
              BotObject.set_role_permission(role.id, 2)
            end
            SaberConfig.server_roles[server][role.name] = role
          end
          server.channels.each do |channel|
            SaberConfig.server_channels[server][channel.name] = channel
          end
        end
      end
    end

    # set our "playing" message when we connect
    module SetGameString
      extend Discordrb::EventContainer
      ready do
        BotObject.game = SaberConfig.settings['game_string']
      end
    end

    # start the slowmde counter reset-loop!
    module SlowmodeLoop
      extend Discordrb::EventContainer
      ready do
        SaberBot::Loop.slowmode
      end
    end
  end
end
