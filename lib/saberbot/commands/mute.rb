# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Mute
      extend Discordrb::Commands::CommandContainer

      command(:mute, description: "Mute a user. Staff only.", permission_level: 1, min_args: 1) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0].id)
          if member.role?(Server_roles[event.server][Config['staff_role']])
            event.channel.send("Error: You cannot mute a fellow staff member!")
            break
          end
          details = {sid: event.server.id, mention: member.mention, distinct: member.distinct, staff: event.message.author.mention}
          member.add_role(Server_roles[event.server][Config["mute_role"]])
          event.channel.send("Muted #{details[:mention]}.")
          Server_channels[event.server][Config["modlog_channel"]].send("**Muted:** #{details[:mention]} || #{details[:distinct]}\n**Responsible Moderator:** #{details[:staff]}")
          Mutes[member.id] = details
          nil
        else
          "Invalid argument. Please mention a valid user."
        end
      end

      command(:unmute, description: "Unmute. Staff only.", permission_level: 1, min_args: 1) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0].id)
          member.remove_role(Server_roles[event.server][Config["mute_role"]])
          event.channel.send("Unmuted #{member.mention}.")
          Server_channels[event.server][Config["modlog_channel"]].send("**Unmuted:** #{member.mention} || #{member.distinct}\n**Responsible Moderator:** #{event.message.author.mention}")
          Mutes.delete(member.id)
          nil
        else
          "Invalid argument. Please mention a valid user."
        end
      end

    end
  end
end
