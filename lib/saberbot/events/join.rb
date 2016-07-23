# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event

    module LogJoin
      extend Discordrb::EventContainer
      member_join do |event|
        Server_channels[event.server][Config["log_channel"]].send("Joined: #{event.user.mention} || #{event.user.distinct}\nAccount creation date: #{event.user.creation_time.getutc.asctime} UTC")
      end
    end

    module AutoProbate
      extend Discordrb::EventContainer
      member_join do |event|
        if Config["autoprobate"] then
          event.server.member(event.user.id).add_role(Server_roles[event.server][Config["probation_role"]])
        end
      end
    end

    module AutoPunish
      extend Discordrb::EventContainer
      member_join do |event|
        member = event.server.member(event.user.id)
        if Mutes[member.id] then
          member.add_role(Server_roles[event.server][Config["mute_role"]])
        end
        if NoEmbeds[member.id] then
          member.add_role(Server_roles[event.server][Config["noembed_role"]])
        end
      end
    end

  end
end
