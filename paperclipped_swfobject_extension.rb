require 'swfheader/swfheader'
class PaperclippedSwfobjectExtension < Radiant::Extension
  version "0.1"
  description "Adds SWFObject embedding support for Paperclipped SWF Assets"
  url "http://github.com/moklett/radiant-paperclipped-swfobject-extension"
  
  def activate
    Page.send :include, PaperclippedSwfobjectTags
  end
  
  def deactivate
  end
  
end