# name: sketchup_3dwh_onebox
# about: Discourse plugin for embedding SketchUp 3D Warehouse models in a onebox
# version: 0.1
# authors: Andreas Eisenbarth

register_asset "stylesheets/sketchup_3dwh_onebox.css"

# Without this, there is an error when loading/precompiling:
# NoMethodError: undefined method `matches_regexp'
Onebox = Onebox

module Onebox
  module Engine
    class SketchUp3dwhOnebox
      include Engine

      def self.priority
        0
      end

      BASE_URL = "https://3dwarehouse.sketchup.com"
      # Matches details page (model.html?id=) and embed codes (embed.html?mid=)
      # for old 32 digit hexadecimal id and new uuid.
      REGEX = /^(?:https?:\/\/)3dwarehouse\.sketchup\.com\/(?:model\.html\?id=|embed\.html\?mid=)([a-fA-F0-9]{32}|[uU][a-fA-F0-9\-]{36})\S*$/

      # Register the regular expression for testing if the onebox handles a certain link:
      matches_regexp REGEX

      # Called to generate a html preview.
      # We first show a static image, and on click replace it by the webgl viewer.
      # Since 3D Warehouse does not give links to images, we use an iframe for
      # both static image and 3d view.
      def to_html
        w = 400
        h = 300
        id = @url.match(REGEX)[1]
        embed_image = "#{BASE_URL}/embed.html?mid=#{id}&width=#{w}&height=#{h}&etp=im"
        embed_3d = "#{BASE_URL}/embed.html?mid=#{id}&width=#{w}&height=#{h}"
        <<HTML
<div class="onebox-3dwh" id="#{id}">
  <iframe src="#{embed_image}" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="#{w}" height="#{h}" allowfullscreen></iframe>
  <div class="onebox-3dwh-circle" onclick="$('##{id} iframe').attr('src', '#{embed_3d}'); $(this).remove()" />
</div>
HTML
      end

    end
  end
end
