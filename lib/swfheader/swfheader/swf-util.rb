module SwfUtil
  def self.read_header(file)
    raise ArgumentError.new("file is nil",caller) if file.nil? 
    SWFHeader.new(file)
  end
  def self.compress_swf(from,to=from.sub(/\.swf/,'_comp.swf'))
    SWFCompressor.new(from,to)
  end
  def self.decompress_swf(from,to=from.sub(/\.swf/,'de_comp.swf'))
    SWFDecompressor.new(from,to)
  end
end