# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module NoEmbed
      extend Discordrb::Commands::CommandContainer

      command(:noembed, description: "Remove a user's media privileges. Staff only.", permission_level: 1, min_args: 1) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0].id)
          if member.role?(Server_roles[event.server][Config['staff_role']])
            event.channel.send("Error: You cannot remove a fellow staff member's media privileges!")
            break
          end
          details = {sid: event.server.id, mention: member.mention, distinct: member.distinct, staff: event.message.author.mention}
          member.add_role(Server_roles[event.server][Config["noembed_role"]])
          event.channel.send("Removed #{details[:mention]}'s media privileges.")
          Server_channels[event.server][Config["modlog_channel"]].send("**No-Embed:** #{details[:mention]} || #{details[:distinct]}\n**Responsible Moderator:** #{details[:staff]}")
          NoEmbeds[member.id] = details
          nil
        else
          "Invalid argument. Please mention a valid user."
        end
      end

      command(:embed, description: "Restore a user's media privileges. Staff only.", permission_level: 1, min_args: 1) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0].id)
          event.channel.send("Restored #{member.mention}'s media privileges.")
          member.remove_role(Server_roles[event.server][Config["noembed_role"]])
          Server_channels[event.server][Config["modlog_channel"]].send("**Embed:** #{member.mention} || #{member.distinct}\n**Responsible Moderator:** #{event.message.author.mention}")
          NoEmbeds.delete(member.id)
          nil
        else
          "Invalid argument. Please mention a valid user."
        end
      end

    end
  end
end
