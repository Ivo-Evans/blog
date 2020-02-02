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
end
