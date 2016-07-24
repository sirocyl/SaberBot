# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # !ban a @user, !unban a user#1234
    module Ban
      extend Discordrb::Commands::CommandContainer
      command(
        :ban,
        description: "Ban a user. Staff only.\n" \
        "Usage: `!ban <user> <time, ex: 30d1w9h50s> <reason>`",
        min_args: 2
      ) do |event, _user|
        break if event.channel.private?

        if event.message.author.permission?(:ban_members)
          if event.message.mentions[0]
            args = event.message.content.split(' ')
            member = event.server.member(event.message.mentions[0].id)
            time = SaberBot.parse_time(args[2])

            if member.role?(SaberConfig.server_roles[event.server][SaberConfig.settings['staff_role']])
              event.channel.send('Error: You cannot ban a fellow staff member!')
              break
            end

            unless time
              event.channel.send('Invalid argument. Please specify a valid time format.')
              break
            end

            reason = args[3..-1].join(' ')
            reason += '.' unless reason.end_with?('.')
            details = {
              sid: event.server.id,
              mention: member.mention,
              distinct: member.distinct,
              staff: event.message.author.mention,
              time: time,
              start_time: Time.now.utc,
              stop_time: Time.now.to_i + time,
              reason: reason
            }

            member.pm(
              "**You have been banned from #{event.server.name}!**\n" \
              "**Expiry:** #{ChronicDuration.output(details[:time], :format => :short)} (#{DateTime.strptime(details[:stop_time].to_s, '%s')})\n" \
              "**Responsible staff member:** #{event.author.mention}\n\n" \
              "**Reason:** #{reason}"
            )

            event.server.ban(member)
            SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
              "**Banned:** #{details[:mention]} || #{details[:distinct]}\n" \
              "**Time:** #{ChronicDuration.output(details[:time], :format => :short)}\n" \
              "**Reason:** #{details[:reason]}\n" \
              "**Responsible Moderator:** #{details[:staff]}"
            )
            SaberConfig.bans[member.id] = details
            nil
          else
            'Invalid argument. Please mention a valid user.'
          end
        else
          "You don't have permission to execute command `ban`!"
        end
      end

      command(
        :unban,
        description: "Unban a user. Staff only.\n
        Usage: `!unban <user#0000>`",
        min_args: 1
      ) do |event|
        break if event.channel.private?

        if event.message.author.permission?(:ban_members)
          args = event.message.content.split(' ')
          target = args[1]

          SaberConfig.bans.each do |uid, details|
            next unless target.eql?(details[:distinct])
            server = BotObject.servers[details[:sid]]
            user = server.bans.find { |user| user.id == uid }

            server.unban(user)
            SaberConfig.server_channels[server][SaberConfig.settings['modlog_channel']].send(
              "**Unbanned:** #{details[:mention]} || #{details[:distinct]}\n" \
              "**Responsible Moderator:** #{event.message.author.mention}"
            )
            SaberConfig.bans.delete(uid)
          end
          nil
        else
          "You don't have permission to execute command `unban`!"
        end
      end
    end
  end
end
