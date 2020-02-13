module Compilable
  @tab = "  "

  def compile_article(title, tags, date, content)  
    lines = [
      @tab * 2 + "<article class=\"post\">",
      @tab * 3 + "<span class=\"post-title-bar\"><h2 id=\"#{title}\" class=\"post-title\">#{title}</h2><p class=\"meta-info\">#{date}<br>#{tags.join(", ")}</p></span>",
      @tab * 3 + "<div class=\"post-content\">"
    ]

    content.each {|element| lines.push(@tab * 4 + element)}

    lines + [
      @tab * 4 + "<img class=\"fade\" src=\"./resources/bottom-fade.png\" alt=\"an image that adds a fade effect to the bottom layer\">",
      @tab * 3 + "</div>",
      @tab * 3 + "<h3 class=\"expandContractButton\">Read more +</h3>",
      @tab * 2 + "</article>"
    ]
  end
  
  def compile_archive(titles, namer)
    titles.each_with_index do |e, i|
      titles[i] = @tab * 2 + "<p><a class=\"archive-link\"href=\"#{namer[i / 10]}##{e}\">#{e}</a></p>"
    end
  end
  
  def compile_pagination(this_n, total_n, namer)
    (0..total_n - 1).map do |e| 
      address = namer[e]
      if e == this_n 
        @tab * 3 + "<h3><a class=\"current-page\" href=\"#{address}\">#{e}</a></h3>"
      else
        @tab * 3 + "<h3><a class=\"non-current-page\" href=\"#{address}\">#{e}</a></h3>"
      end
    end
  end
end