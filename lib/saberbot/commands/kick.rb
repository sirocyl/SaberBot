# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # !kick a user from the chat
    module Kick
      extend Discordrb::Commands::CommandContainer
      command(
        :kick,
        description: "Kick a user. Staff only.\nUsage: `!kick <user> <reason>`",
        min_args: 1
      ) do |event|
        break if event.channel.private?

        if event.message.author.permission?(:kick_members)
          if event.message.mentions[0]
            args = event.message.content.split(' ')
            member = event.server.member(event.message.mentions[0].id)
            reason = args[2..-1].join(' ')
            reason += '.' unless reason.end_with?('.')
            details = {
              sid: event.server.id,
              mention: member.mention,
              distinct: member.distinct,
              staff: event.message.author.mention,
              reason: reason
            }

            if member.role?(SaberConfig.server_roles[event.server][SaberConfig.settings['staff_role']])
              event.channel.send('Error: You cannot kick a fellow staff member!')
              break
            end

            member.pm(
              "**You have been kicked from #{event.server.name}!**\n" \
              "**Responsible staff member:** #{event.message.author.mention}\n\n" \
              "**Reason:** #{reason}"
            )

            event.server.kick(member)

            SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
              "**Kicked:** #{details[:mention]} || #{details[:distinct]}\n" \
              "**Reason:** #{details[:reason]}\n" \
              "**Responsible Moderator:** #{details[:staff]}"
            )
            'User kicked.'
          else
            'Invalid argument. Please mention a valid user.'
          end
        else
          "You don't have permission to execute command `kick`!"
        end
      end
    end
  end
end
