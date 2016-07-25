# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    # log when people join the server
    module LogJoin
      extend Discordrb::EventContainer
      member_join do |event|
        SaberConfig.server_channels[event.server][SaberConfig.settings['log_channel']].send(
          "Joined: #{event.user.mention} || #{event.user.distinct}\n" \
          "Account creation date: #{event.user.creation_time.getutc.asctime} UTC"
        )
      end
    end

    # automatically put new users in probation, sometimes
    module AutoProbate
      extend Discordrb::EventContainer
      member_join do |event|
        event.server.member(event.user.id).add_role(SaberConfig.server_roles[event.server][SaberConfig.settings['probation_role']]) if SaberConfig.settings['autoprobate']
      end
    end

    # re-apply noembed and mute to users who are rejoining
    module AutoPunish
      extend Discordrb::EventContainer
      member_join do |event|
        member = event.server.member(event.user.id)
        member.add_role(SaberConfig.server_roles[event.server][SaberConfig.settings['mute_role']]) if SaberConfig.mutes[member.id]
        member.add_role(SaberConfig.server_roles[event.server][SaberConfig.settings['noembed_role']]) if SaberConfig.noembeds[member.id]
      end
    end
  end
end
