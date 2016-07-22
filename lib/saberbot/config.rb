#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module SaberConfig
    def SaberConfig.read_config
      if File.size?("#{Dir.pwd}/data/config.yml")
        return YAML.load_file("#{Dir.pwd}/data/config.yml")
      else
        puts "Config file missing or empty! Please configure it!"
        exit
      end
      return Hash.new
    end
    def SaberConfig.read_staff
      if File.size?("#{Dir.pwd}/data/staff.yml")
        return YAML.load_file("#{Dir.pwd}/data/staff.yml")
      end
      return Hash.new
    end
    def SaberConfig.read_bans
      if File.size?("#{Dir.pwd}/data/bans.yml")
        return YAML.load_file("#{Dir.pwd}/data/bans.yml")
      end
      return Hash.new
    end
    def SaberConfig.write_bans
      File.open("#{Dir.pwd}/data/bans.yml", "w") { |f| f.write Bans.to_yaml }
    end
    def SaberConfig.read_mutes
      if File.size?("#{Dir.pwd}/data/mutes.yml")
        return YAML.load_file("#{Dir.pwd}/data/mutes.yml")
      end
      return Hash.new
    end
    def SaberConfig.write_mutes
      File.open("#{Dir.pwd}/data/mutes.yml", "w") { |f| f.write Mutes.to_yaml }
    end
    def SaberConfig.read_noembeds
      if File.size?("#{Dir.pwd}/data/noembeds.yml")
        return YAML.load_file("#{Dir.pwd}/data/noembeds.yml")
      end
      return Hash.new
    end
    def SaberConfig.write_noembeds
      File.open("#{Dir.pwd}/data/noembeds.yml", "w") { |f| f.write NoEmbeds.to_yaml }
    end
    def SaberConfig.write_staff
      File.open("#{Dir.pwd}/data/staff.yml", 'w') { |f| f.write Roles.to_yaml }
    end
  end
end
