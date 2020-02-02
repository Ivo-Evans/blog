module Readable
  def read_article(filepath)
    file = open(filepath, 'r')
    file_contents = file.read.chomp
    file.close
    file_contents
  end

  def parse_article(string)
    string = read_article(string)
    title = parse_title(string)
    tags = parse_tags(string)
    date = parse_date(string)
    content = parse_content(string)
    compile_article(title, tags, date, content)
  end

  def parse_title(string)
    title = string[/(?<=^title: ).*$/]
    title ? title : ""
  end

  def parse_tags(string)
    tags = tags = string[/(?<=^tags: ).*$/]
    tags ? tags.split(', ') : ""
  end

  def parse_date(string)
    date = string[/(?<=^date: ).*$/]
    date ? date : ""
  end

  def parse_content(string)
    content = string[/(?<=CONTENT\n)[\w\W]*(?=\nCONTENT)/]
    content ? content.split("\n\n") : ""
  end

  # def compile_article(title, tags, date, content)
  #   tab = "  "

  #   lines = [tab * 2 + "<article class=\"post\">"]
  #   lines.push(tab * 3 + "<span class=\"post-title-bar\"><h2 id=\"#{title}\" class=\"post-title\">#{title}</h2><p class=\"meta-info\">#{date}<br>#{tags.join(", ")}</p></span>")
  #   lines.push(tab * 3 + "<div class=\"post-content\">")
  #   content.each {|element| lines.push(tab * 4 + element)}
  #   lines.push(tab * 4 + "<img class=\"fade\" src=\"./resources/bottom-fade.png\" alt=\"an image that adds a fade effect to the bottom layer\">")
  #   lines.push(tab * 3 + "</div>")
  #   lines.push(tab * 3 + "<h3 class=\"expandContractButton\">Read more +</h3>")
  #   lines.push(tab * 2 + "</article>")
  # end
end
