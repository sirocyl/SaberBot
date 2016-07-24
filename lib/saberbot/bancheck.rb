# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Iterate through the ban list and check if any are now expired. If so, unban.
module SaberBot
  def self.bancheck
    SaberConfig.bans.each do |uid, details|
      next unless details[:stop_time] <= Time.now.to_i

      server = BotObject.servers[details[:sid]]
      user = server.bans.find { |user| user.id == uid }

      server.unban(user)
      SaberConfig.server_channels[server][SaberConfig.settings['modlog_channel']].send(
        "**Unbanned:** #{details[:mention]} || #{details[:distinct]}"
      )
      SaberConfig.bans.delete(uid)
    end
  end
end
