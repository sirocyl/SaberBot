# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# functions for reading and writing the important stuff :)
module SaberConfig
  class << self
    attr_accessor :settings
    attr_accessor :roles
    attr_accessor :bans
    attr_accessor :mutes
    attr_accessor :noembeds
    attr_accessor :logchannels
    attr_accessor :ignorechannels
    attr_accessor :slowmode_counters
    attr_accessor :slowmode_maxmsgs
    attr_accessor :server_roles
    attr_accessor :server_channels
  end
  SaberConfig.settings = {}
  SaberConfig.roles = {}
  SaberConfig.bans = {}
  SaberConfig.mutes = {}
  SaberConfig.noembeds = {}
  SaberConfig.logchannels = {}
  SaberConfig.ignorechannels = {}
  SaberConfig.slowmode_counters = {}
  SaberConfig.slowmode_maxmsgs = {}
  SaberConfig.server_roles = {}
  SaberConfig.server_channels = {}

  def self.read_config
    if File.size?("#{Dir.pwd}/data/config.yml")
      return YAML.load_file("#{Dir.pwd}/data/config.yml")
    else
      puts 'Config file missing or empty! Please configure it!'
      exit
    end
    {}
  end

  def self.read_staff
    if File.size?("#{Dir.pwd}/data/staff.yml")
      return YAML.load_file("#{Dir.pwd}/data/staff.yml")
    end
    {}
  end

  def self.write_staff
    File.open("#{Dir.pwd}/data/staff.yml", 'w') { |f| f.write SaberConfig.roles.to_yaml }
  end

  def self.read_bans
    if File.size?("#{Dir.pwd}/data/bans.yml")
      return YAML.load_file("#{Dir.pwd}/data/bans.yml")
    end
    {}
  end

  def self.write_bans
    File.open("#{Dir.pwd}/data/bans.yml", 'w') { |f| f.write SaberConfig.bans.to_yaml }
  end

  def self.read_mutes
    if File.size?("#{Dir.pwd}/data/mutes.yml")
      return YAML.load_file("#{Dir.pwd}/data/mutes.yml")
    end
    {}
  end

  def self.write_mutes
    File.open("#{Dir.pwd}/data/mutes.yml", 'w') { |f| f.write SaberConfig.mutes.to_yaml }
  end

  def self.read_noembeds
    if File.size?("#{Dir.pwd}/data/noembeds.yml")
      return YAML.load_file("#{Dir.pwd}/data/noembeds.yml")
    end
    {}
  end

  def self.write_noembeds
    File.open("#{Dir.pwd}/data/noembeds.yml", 'w') { |f| f.write SaberConfig.noembeds.to_yaml }
  end
end
