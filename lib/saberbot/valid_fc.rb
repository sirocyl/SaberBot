# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Check if an FC is *actually* valid
module SaberBot
  def self.fc_to_int(fc_s)
    begin
      fc = Integer(fc_s.delete('-'), 10)
    rescue ArgumentError
      return nil
    end

    # input FC is out of range
    return nil if fc < 0x01_00000000 || fc > 0x7F_FFFFFFFF

    fc
  end

  def self.valid_fc?(fc_s)
    fc = fc_to_int(fc_s)
    return false unless fc

    principal_id = fc & 0xFFFFFFFF
    checksum = (fc & 0xFF00000000) >> 32

    (Digest::SHA1.digest([principal_id].pack('L<'))[0].ord >> 1) == checksum
  end
end
