#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module SaberConfig
    def SaberConfig.read_config
      return YAML.load_file("#{Dir.pwd}/data/config.yml")
    end
    def SaberConfig.read_staff
      return YAML.load_file("#{Dir.pwd}/data/staff.yml")
    end
    def SaberConfig.write_staff
      File.open("#{Dir.pwd}/data/staff.yml", 'w') { |f| f.write Roles.to_yaml }
    end
  end
end
