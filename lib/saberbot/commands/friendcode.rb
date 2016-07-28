# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # !fcregister nnnn-nnnn-nnnn, !fcquery {user}
    module Friendcodes
      extend Discordrb::Commands::CommandContainer
      command(
        :fcregister,
        description: "Register friend code for your user with the bot.\n" \
                     'Usage: `!fcregister nnnn-nnnn-nnnn`',
        min_args: 1,
        max_args: 1
      ) do |event, friendcode|
        if SaberConfig.friendcodes.filter(user: event.message.author.mention).count == 0
          if SaberBot.valid_fc(friendcode)
            SaberConfig.friendcodes.insert(
              user: event.message.author.mention.to_s,
              fc: friendcode.to_s
            )

            event.channel.send('Successfully registered friendcode!')
          else
            event.channel.send('Invalid friendcode!')
          end

        else

          event.channel.send('Please delete your old FC before adding a new one!')

        end
      end

      command(
        :fcquery,
        description: "Lookup friendcode of a user.\n" \
                     'Usage: `!fcquery <user>`',
        min_args: 1,
        max_args: 1
      ) do |event, user|
        user = user.delete! '!' if user.include? '!'

        if SaberConfig.friendcodes.filter(user: event.message.author.mention).count == 0
          event.channel.send('You need to register a FC before looking up others!')
          break
        end

        if SaberConfig.friendcodes.filter(user: user).count == 0
          event.channel.send('User does not have a friendcode registered!')
          break
        end

        user_fc = SaberConfig.friendcodes.filter(user: user)
        user_fc.each { |entry| event.channel.send(entry[:fc]) }

        author_fc = SaberConfig.friendcodes.filter(user: event.message.author.mention)

        event.message.mentions[0].pm(
          "#{event.message.author.mention} has requested to add your 3ds friend code!\n\n" \
          "Their FC is #{author_fc.first[:fc]}"
        )
      end

      command(
        :fcdelete,
        description: "Delete the FC associated with your account.\n" \
                     'Usage: `!fcdelete`',
        max_args: 0
      ) do |event|
        SaberConfig.friendcodes.where(user: event.message.author.mention).delete
        'Successfully deleted record!'
      end
    end
  end
end
