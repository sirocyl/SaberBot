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
    attr_accessor :friendcodes
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
  SaberConfig.friendcodes = nil

  def self.read_yml(file)
    if File.size?("#{Dir.pwd}/data/#{file}.yml")
      return YAML.load_file("#{Dir.pwd}/data/#{file}.yml")
    end
    {}
  end

  def self.write_yml(file, data)
    File.open("#{Dir.pwd}/data/#{file}.yml", 'w') { |f| f.write data.to_yaml }
  end

  def self.read_database(file)
    filepath = "#{Dir.pwd}/data/#{file}.sqlite3"
    initialized = File.size?(filepath)
    db = Sequel.connect("sqlite://#{filepath}")
    initialize_database(db) unless initialized
    db
  end

  def self.initialize_database(db)
    db.create_table :friendcodes do
      primary_key :id
      String :user
      String :fc
    end
  end
end
