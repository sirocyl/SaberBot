# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    # log when people join the server
    module LogRoleUpdate
      extend Discordrb::EventContainer
      member_update do |event|
        member = event.server.member(event.user.id)
        roles = member.roles
        list = Array.new
        roles.each { |r| list.push("#{r.name} (#{r.id})") }
        SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
          "**Role Update:** #{member.mention} || #{member.distinct}\n" \
          "**Roles:** #{list.join(', ')}"
        )
      end
    end
  end
end
