require './resources/modules/writable.rb'

module Compilable
  @tab = "  "

  def compile_article(title, tags, date, content)
  
    lines = [@tab * 2 + "<article class=\"post\">"]
    lines.push(@tab * 3 + "<span class=\"post-title-bar\"><h2 id=\"#{title}\" class=\"post-title\">#{title}</h2><p class=\"meta-info\">#{date}<br>#{tags.join(", ")}</p></span>")
    lines.push(@tab * 3 + "<div class=\"post-content\">")
    content.each {|element| lines.push(@tab * 4 + element)}
    lines.push(@tab * 4 + "<img class=\"fade\" src=\"./resources/bottom-fade.png\" alt=\"an image that adds a fade effect to the bottom layer\">")
    lines.push(@tab * 3 + "</div>")
    lines.push(@tab * 3 + "<h3 class=\"expandContractButton\">Read more +</h3>")
    lines.push(@tab * 2 + "</article>")
  end
  
  def compile_archive(titles)
    titles.each_with_index do |e, i|
      titles[i] = @tab * 2 + "<p><a class=\"archive-link\"href=\"./#{name_index_page(i / 10)}##{e}\">#{e}</a></p>"
    end
  end  
end

# TODO: fix archive links - they currently go to docs/docs