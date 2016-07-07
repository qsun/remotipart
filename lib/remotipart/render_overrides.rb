module Remotipart
  # Responder used to automagically wrap any non-xml replies in a text-area
  # as expected by iframe-transport.
  module RenderOverrides
    include ERB::Util

    def render *args
      super
      if remotipart_submitted?
        textarea_body = response.content_type == 'text/html' ? html_escape(response.body) : response.body
        response.body = %{<script type=\"text/javascript\">try{window.parent.document;}catch(err){document.domain=document.domain;}</script>#{textarea_body}}
        response.content_type = Mime::HTML
      end
      response_body
    end
  end
end
