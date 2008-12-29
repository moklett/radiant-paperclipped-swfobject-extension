Paperclipped SWFObject Add-on
=============================

This extension adds support for embedding/displaying Flash movies (.swf files), managed via
[Paperclipped][], in to your Radiant site via the [SWFObject][] method of dynamic publishing.

[Paperclipped]: http://github.com/kbingman/paperclipped/tree/master
[SWFObject]:    http://code.google.com/p/swfobject/

--------------------------------------------------------------------------------

Two tags are available:

    <r:assets:swfembed [flash_version="<string>"] [namespace="<string>"]/>
    
    <r:assets:swfobject id="<integer>" [namespace="<string>"] [alt="<string>"] />
    

`r:assets:swfembed`
-------------------

This tag should be placed within your document `<head>` tag.  If any .swf files are attached to the
page currently being displayed, this tag will output javascript include for `swfobject.js`, as well as
an `swfEmbed` call for each attached .swf asset.

#### Attributes

**`flash_version`** (Optional): Used to specify the minimum required version of Macromedia/Adobe 
Flash Player. (Defaults to "9.0.0")

**`namespace`** (Optional): Used to specify a namespace for the html `id` attributes used to identify
the Flash content container.  This `namespace` is suffixed with the ID of the Paperclipped Asset being
referenced to create the final id. (Defaults to `pcswf_`)

TODO: Support for flashvars and other params.

##### Namespace Example

If the namespace is `pcswf_` and the ID of the attribute being referenced is `6`, then the ID
attribute of the Flash container will be `pcswf_6`.


`r:assets:swfobject`
--------------------

This tag should be placed where you would like the Flash movie to appear in your document.
It can be used as either a double or a single tag.

+ If used as a double tag, the contents of the tag will be used as the alternate content when 
either the Flash player is not present or Javascript is disabled.
+ If used as a single tag, the alternate content can be specified using the `alt` attribute.
+ If used as a single tag AND no `alt` attribute is specified, the default alternate content will
be inserted (see below).

#### Attributes

**`id`** (Required, unless an asset has already been set in to context by an outer `r:assets` tag): 
Used to identify the asset being referenced.  This corresponds to the database ID of the Asset.
Note: Specifying an asset via the `title` attribute, as is supported in Paperclipped, is not
supported here.

**`namespace`** (Optional): Used to specify a namespace for the html `id` attributes used to identify
the Flash content container.  This `namespace` is suffixed with the ID of the Paperclipped Asset being
referenced to create the final id. **This should match the namespace specified in the 
`r:assets:swfembed` tag. (Defaults to `pcswf_`)

#### Default Alternate Content

The default alternate content for the Flash movie can be specified via the Radiant Config key
`assets.swfobject.default_alternate_content`.  For example, at the console you could issue:

    Radiant::Config['assets.swfobject.default_alternate_content'] = "My alternate content"
    
You can also use the [Settings Extension][] to manage this and all of the other Radiant Config values.

[Settings Extension]: http://github.com/Squeegy/radiant-settings/tree/master

If no value is given for this Config key, the extension falls back on its default alternate content,
which is currently set as the following:

    <div class="swfalt">
        In order to view this content, you must have the Flash Player
        installed, and Javascript enabled in your browser.
    </div>
    
TODO: Add helpful links to this default content for installing Flash Player or enabling Javascript.

--------------------------------------------------------------------------------

Installation
------------

Place the extension files within the directory `vendor/extensions/paperclipped_swfobject` and run

    rake radiant:extensions:paperclipped_swfobject:update
    
This rake task copies 2 files to your project's public directory:

1. `javascripts/swfobject.js`: The SWFObject javascript
2. `images/expressInstall.swf`: A default express installation movie (See the [SWFObject Documentation][]
for more information) (Note: I haven't even tried this out yet... not really sure what value it adds)

[SWFObject Documentation]: http://code.google.com/p/swfobject/wiki/documentation


Dependencies and Versions
-------------------------

This extension includes [swf-util][], and open-source application that reads SWF headers.  It is used
within this extension to automatically deduce the width and height of the Flash Movie.  The trunk version
as of Dec. 29th, 2008 has been included.

This extension includes version 2.1 of [SWFObject][], an open-source application used to embed Flash
movies using web standards.

[swf-util]: http://code.google.com/p/swf-util/
[SWFObject]: http://code.google.com/p/swfobject/


Disclaimer
----------

This extension and documentation are still very alpha and untested.  I will likely contact the maintainer
of Paperclipped to see about folding this functionality in to that project.