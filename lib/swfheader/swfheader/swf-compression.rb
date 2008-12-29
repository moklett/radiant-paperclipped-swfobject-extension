module SwfUtil
  class SWFCompression
    def read_full_size(file)
      buff = nil
      File.open(file,"rb") do |f|
        f.seek(4,IO::SEEK_CUR)
        buff = f.read 4
      end
      return buff.unpack("L")[0]
    end
    def strip_header(bytes)
      bytes[8,bytes.size-8]
    end
    def is_compressed?(first_byte)
      if first_byte==67
        return true
      else
        return false
      end
    end
  end
end

