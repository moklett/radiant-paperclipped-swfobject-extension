module PaperclippedSwfobjectTags
  include Radiant::Taggable
  PAPERCLIPPED_SWFOBJECT_NAMESPACE = "pcswf_"

  tag 'assets:swfembed' do |tag|
    swfs = tag.locals.page.assets.select{|a| a.asset_content_type == 'application/x-shockwave-flash'}
    flash_version = tag.attr.delete('flash_version') || "9.0.0"
    namespace = tag.attr.delete('namespace') || PAPERCLIPPED_SWFOBJECT_NAMESPACE
    attributes = tag.attr.inject('') { |s, (k, v)| s << %{#{k.downcase}="#{v}" } }.strip
    output = ''
    unless swfs.empty?
      output << %{<script type="text/javascript" src="/javascripts/swfobject.js" #{attributes}></script>\n}
      output << %{<script type="text/javascript">\n}
      swfs.each do |swf|
        swf_header = SwfUtil::read_header(File.join(RAILS_ROOT, "public#{swf.asset.url}"))
        output << %{swfobject.embedSWF("#{swf.asset.url}", "#{namespace}#{swf.id}", "#{swf_header.width}", "#{swf_header.height}", "#{flash_version}", "/images/expressInstall.swf");\n}
      end
      output << %{</script>\n}
    end
    output
  end

  tag 'assets:swfobject' do |tag|
    default_alt = Radiant::Config['assets.swfobject.default_alternate_content'] || %{<div class="swfalt">In order to view this content, you must have the Flash Player installed, and Javascript enabled in your browser.</div>}
    alt = tag.double? ? tag.expand : (tag.attr.delete('alt') || default_alt)
    namespace = tag.attr.delete('namespace') || PAPERCLIPPED_SWFOBJECT_NAMESPACE
    asset = find_asset(tag, tag.attr.dup)
    %{<div id="#{namespace}#{asset.id}">#{alt}</div>}
  end
end
