module Readable
  def read(filepath)
    file = open(filepath, 'r')
    file_contents = file.read
    html = parse(file_contents)
    file.close
    html
  end

  def parse(string)
    title = parse_title(string)
    tags = parse_tags(string)
    date = parse_date(string)
    content = parse_content(string)
    compile(title, tags, date, content)
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

  def compile(title, tags, date, content)
    tab = "  "
    lines = [tab + "<article>"]
    lines.push(tab + tab + "<span class=\"post-title-bar\"><h2 id=\"#{title}\" class=\"post-title\">#{title}</h2><p class=\"meta-info\">#{date}<br>#{tags.join(", ")}</p></span>")
    lines.push(tab + tab + "<div class=\"post-content\">")
    content.each {|element| lines.push("      " + element)}
    lines.push(tab + tab + "</div>")
    lines.push(tab + tab + "<h3 class=\"expandContractButton\">Read more +</h3>")
    lines.push(tab + "</article>")
  end
end
