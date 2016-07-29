# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # add and remove staff users
    module Staff
      extend Discordrb::Commands::CommandContainer
      command(
        :addstaff,
        description: 'Add a staff member to a powered role. Admins only.',
        permission_level: 2,
        min_args: 2
      ) do |event, _user, role_name|
        break if event.channel.private?

        if event.message.mentions[0]
          if SaberConfig.server_roles[event.server][role_name]
            member = event.server.member(event.message.mentions[0])
            role = SaberConfig.server_roles[event.server][role_name]

            member.add_role(SaberConfig.server_roles[event.server][SaberConfig.settings['staff_role']])
            SaberConfig.roles[member.id] = role.id
            SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
              "**Staff Addition:** #{member.mention} as #{role.name}\n" \
              "**Responsible Moderator:** #{event.message.author.mention}"
            )
            "User has been added as #{role.name}. Welcome aboard!"
          else
            'Invalid argument. Please specify a valid role.'
          end
        else
          'Invalid argument. Please mention a valid user.'
        end
      end

      command(
        :delstaff,
        description: 'Remove a staff member. Admins only.',
        permission_level: 2,
        min_args: 1
      ) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0])

          if SaberConfig.roles[member.id]
            member.remove_role(event.server.role(SaberConfig.roles[member.id]))
            member.remove_role(SaberConfig.server_roles[event.server][SaberConfig.settings['staff_role']])
            SaberConfig.roles.delete(member.id)
            SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
              "**Staff Deletion:** #{member.mention}\n" \
              "**Responsible Moderator:** #{event.message.author.mention}"
            )
            'User has been removed from staff. See you!'
          else
            "Error: target user ID isn't saved in the sudo list."
          end
        end
      end
    end
  end
end
