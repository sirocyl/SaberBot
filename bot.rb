#!/usr/bin/env ruby
# encoding: utf-8

require 'discordrb'
require 'yaml'

Config = YAML.load_file('config.yml')
Roles = YAML.load_file('staff.yml')

## These hashes hold the settings for server/channel specific value
slowmode_counters = Hash.new  # Stores the current number of messages per second for a slowmode-enabled channel
slowmode_maxmsgs  = Hash.new  # Stores the maximum amount of messages per second for a slowmode-enabled channel
logchannels       = Hash.new  # Stores server-specific log channel objects
ignorechannels    = Hash.new  # Stores server-specific objects for channels not meant to be logged
server_roles      = Hash.new  # Create hash with format {server, {role_name, role}}
server_channels   = Hash.new  # Create hash with format {server, {channel_name, channel}}

##### Initialize a bot object to work with
bot = Discordrb::Commands::CommandBot.new(                                           # CommandBot provides an easy way to create command triggers
                                          token:          Config["auth_token"],      # Discord API token for bot accounts
                                          application_id: Config["app_id"],          # Application ID for OAuth2
                                          prefix:         Config["command_prefix"])  # Command prefix for CommandBot's use

# Connect our bot object to Discord and set its Playing message
bot.run :async
bot.game = Config["game_string"]

def botexit
  File.open('staff.yml', 'w') { |f| f.write Roles.to_yaml }
  exit
end

trap("SIGINT") {bot.stop; botexit}
trap("SIGTERM") {bot.stop; botexit}


##### Temporary "custom" commands, because 3dshackers are cancer
bot.command(:s_99, description: "Memes") do  # !s_99
  "**ALL HAIL BRITANNIA!**"
end
bot.command(:rip, description: "Memes") do  # !rip
  "Press F to pay respects."
end
bot.command(:lenny, description: "Memes") do  # !lenny
  "( ͡° ͜ʖ ͡°)"
end
bot.command(:xor, description: "Memes") do  # !xor
  "http://i.imgur.com/nLKATP6.png"
end
bot.command(:permabrocked, description: "Memes") do  # !permabrocked
  "http://i.imgur.com/ARsOh3p.jpg"
end


##### Built-in bot management commands
# !exit - Kills the bot process and disconnect from the server
bot.command(:exit, description: "Disconnect the bot from the server. Admins only.", permission_level: 2) do
  botexit
end


##### Built-in staff commands
## Role elevation commands. These allow staff members to "sudo" to use their staff power & have a role color set.
## This is useful for allowing staff to participate in chat as regular users unless they are needed.
# !sudo - places the staff member into "power mode"
bot.command(:sudo, description: "Elevate permissions. Staff only.", permission_level: 1) do |event|
  role = event.server.role(Roles[event.message.author.id])
  event.message.author.add_role(role)
  "Elevated #{event.message.author.mention} to #{role.name}. Welcome to the twilight zone!"
end
# !unsudo - removes a staff member's powers
#           This should be used as soon as possible by staff members. They should remain "powerless" unless required.
bot.command(:unsudo, description: "Deelevate permissions. Staff only.", permission_level: 1) do |event|
  role = event.server.role(Roles[event.message.author.id])
  event.message.author.remove_role(role)
  "Deelevated #{event.message.author.mention} from #{role.name}."
end

# !clear - Clears the specified number of recent messages from a channel
#          Valid range is 2 - 100
bot.command(:clear, description: "Clear x messages. Staff only.", permission_level: 1, min_args: 1) do |event, amount|
  begin
    event.channel.prune(amount.to_i)
  rescue ArgumentError
    "Invalid amount \"#{amount}\". Expected a number between 2 and 100."
  end
end

# No-Embed management commands. These remove a user's file upload and link preview privileges given a properly configured server
# !noembed - remove a user's privileges
bot.command(:noembed, description: "Remove a user's media privileges. Staff only.", permission_level: 1, min_args: 1) do |event|
  event.server.member(event.message.mentions[0].id).add_role(server_roles[event.server][Config["noembed_role"]])
  "Removed #{event.message.mentions[0].mention}'s media privileges."
end
# !embed - restore a user's privileges
bot.command(:embed, description: "Restore a user's media privileges. Staff only.", permission_level: 1) do |event|
  event.server.member(event.message.mentions[0].id).remove_role(server_roles[event.server][Config["noembed_role"]])
  "Restored #{event.message.mentions[0].mention}'s media privileges."
end

# Probation management commands. Probation mode restricts a user to a "probation" or "newcomers" channel
# !probation - add a user to the probation group
bot.command(:probation, description: "Add a user to probation. Staff only.", permission_level: 1) do |event|
  event.server.member(event.message.mentions[0].id).add_role(server_roles[event.server][Config["probation_role"]])
  "Added #{event.message.mentions[0].mention} to probation."
end
# !unprobation - remove a user from the probation group
bot.command(:unprobation, description: "Remove a user from probation. Staff only", permission_level: 1) do |event|
  event.server.member(event.message.mentions[0].id).remove_role(server_roles[event.server][Config["probation_role"]])
  "Removed #{event.message.mentions[0].mention} from probation."
end
# !autoprobate - admin only. Toggles whether all new users to the server are added to the probation role automatically.
# This is useful for preventing brigading, as it forces new users to be manually admitted by a staff member.
bot.command(:autoprobate, description: "Toggles whether new users are automatically added to probation. Admins only.", permission_level: 2) do
  Config["autoprobate"] = !Config["autoprobate"]
  "Autoprobate is now: #{Config["autoprobate"]}"
end

# User mute management. Muted users cannot send text messages, upload files, or speak in voice channels.
# They may read messages and message history, and may join a voice channel for listening.
# !mute - mutes the specified user
bot.command(:mute, description: "Mute a user. Staff only.", permission_level: 1) do |event|
  role = event.server.role(server_roles[event.server][Config["noembed_role"]])
  event.server.member(event.message.mentions[0].id).add_role(role)
  "Muted #{event.message.mentions[0].mention}."
end
# !unmute - unmutes the specified user
bot.command(:unmute, description: "Unmute a user. Staff only.", permission_level: 1) do |event|
  role = event.server.role(server_roles[event.server][Config["noembed_role"]])
  event.server.member(event.message.mentions[0].id).remove_role(role)
  "Unmuted #{event.message.mentions[0].mention}."
end

# Slowmode management commands. Slowmode allows only a certain number of messages in a channel per second.
# This is useful for extremely active or heated chats and keeps conversation at a reasonable pace.
# !slowmode - puts the current channel in slowmode
bot.command(:slowmode, description: "Set channel into slowmode. Arguments: number of messages per second. Staff only.", permission_level: 1, min_args: 1) do |event, msgs|
  if msgs.to_i < 1 then
    "Invalid amount \"#{msgs}\". Please choose a number of at least 1."
  else
    slowmode_maxmsgs[event.channel] = msgs.to_i
    slowmode_counters[event.channel] = 0
    "Slowmode enabled. You can only send #{msgs} messages in this channel per second."
  end
end
# !slowoff - disables slowmode on the current channel
bot.command(:slowoff, description: "Disable slowmode on a channel. Staff only.", permission_level: 1) do |event|
  slowmode_maxmsgs.delete(event.channel)
  slowmode_counters.delete(event.channel)
  "Slowmode disabled."
end

## Channel lockdown management. Lockdown disables send permissions for all regular users.
## This is particularly useful when staff requires the attention of a channel.
# !lockdown - places a channel into lockdown mode
bot.command(:lockdown, description: "Disable channel send permissions to normal users. Staff only.", permission_level: 1) do |event|
  lockdown = Discordrb::Permissions.new
  lockdown.can_send_messages = true
  event.channel.define_overwrite(server_roles[event.server][Config["everyone_role"]], 0, lockdown)
  "This channel is now in lockdown. Only staff can send messages."
end
# !unlockdown - disables lockdown mode on the current channel
bot.command(:unlockdown, description: "Enable channel send permissions to normal users. Staff only.", permission_level: 1) do |event|
  lockdown = Discordrb::Permissions.new
  lockdown.can_send_messages = false
  event.channel.define_overwrite(server_roles[event.server][Config["everyone_role"]], lockdown, 0)
  "This channel is no longer in lockdown."
end

bot.command(:addstaff, description: "Add a new staff member or modify a staff member's role. Admins only.", permission_level: 2) do |event, user, role_name|
  member = event.server.member(event.message.mentions[0])
  role = server_roles[event.server][role_name]
  member.add_role(server_roles[event.server][Config["staff_role"]])
  Roles[member.id] = role.id
  "Member #{member.mention} has been added as a #{role.name}. Welcome aboard!"
end

bot.command(:delstaff, description: "Remove a staff member. Admins only.", permission_level: 2) do |event|
  member = event.server.member(event.message.mentions[0])
  member.remove_role(server_roles[event.server][Config["staff_role"]])
  Roles.delete(member.id)
  "Member #{member.mention} has been removed from staff. See you!"
end

##### User-level built-in commands
# !logs - posts a link to the server chat logs
bot.command(:logs, description: "Posts the server logs URL") do
  "You can check the logs here: #{Config["log_url"]}"
end


##### Internal code used for several bot functions
## Logging
# User is banned, send message to ban-log channel
bot.user_ban do |event|
  server_channels[event.server][Config["banlog_channel"]].send("User #{event.user.mention} was banned.")
end
# User is unbanned, send message to ban-log channel
bot.user_unban do |event|
  server_channels[event.server][Config["banlog_channel"]].send("User #{event.user.mention}'s ban was lifted.")
end

# User joined server, send message to activity-log channel
# Include account creation date to help identify potential spammers during brigades
bot.member_join do |event|
  server_channels[event.server][Config["log_channel"]].send("Joined: #{event.user.display_name}  || #{event.user.mention} \nAccount creation date: #{event.user.creation_time.getutc.asctime} UTC")
  if Config["autoprobate"] then event.server.member(event.user.id).add_role(server_roles[event.server][Config["probation_role"]]) end
end
# User left server, send message to activity-log channel
bot.member_leave do |event|
  server_channels[event.server][Config["log_channel"]].send("Left: #{event.user.mention}")
end

## Populate the hashes we created earlier
bot.servers.each do |key, server|
  server_roles[server] = Hash.new
  server_channels[server] = Hash.new
end

bot.servers.each do |key, server|
  server.roles.each do |role|
    if role.name == Config["staff_role"]
      bot.set_role_permission(role.id, 1)  # Staff users should have permission to staff-level commands
    elsif role.name == Config["admin_role"]
      bot.set_role_permission(role.id, 2)  # Admin users should have permission to admin-level commands
    end
    server_roles[server][role.name] = role
  end
  server.channels.each do |channel|
    server_channels[server][channel.name] = channel
  end
end

## Slowmode
bot.message do |event|                                                      # When a channel receives a message...
  if slowmode_counters.key? event.channel                                   # If this channel is in slowmode...
    slowmode_counters[event.channel] += 1                                   # add 1 to its counter...
    if slowmode_counters[event.channel] >= slowmode_maxmsgs[event.channel]  # If this message is over the slowmode limit...
      event.message.delete                                                  # then delete it.
    end
  end
end
# Every second, reset slowmode counters to 0
# This apparently needs to be at the very end of the file
loop do
  sleep(1)
  slowmode_counters.each do |channel, counter|
    slowmode_counters[channel] = 0
  end
end
