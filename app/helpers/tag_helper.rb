module TagHelper
  def linked_tag_list(tags)
    tags.collect {|tag| link_to(h(tag.name), posts_path(:tag => tag))}.join(", ")
  end
  
  def cdata(&block)
    text = capture_haml(&block)
    text.gsub!("\n", "\n  ")
    "<![[CDATA\n  #{text}\n]]>"
  end
  
  def js_for_disqus_thread_link
    <<-EOF
      (function() {
        var links = document.getElementsByTagName('a');
        var query = '?';
        for(var i = 0; i < links.length; i++) {
          if(links[i].href.indexOf('#disqus_thread') >= 0) {
            query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
          }
        }
        document.write('<script charset="utf-8" type="text/javascript"   src="http://disqus.com/forums/optimiere/get_num_replies.js' + query + '"></' + 'script>');
      })();
EOF
  end
  
  def link_to_related_archive
    "Suchst du mehr? Dann check das #{ link_to("Archiv", archives_path) } aus."
  end
end
