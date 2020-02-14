module Readable
  def read_article(filepath)
    file = open(filepath, 'r')
    file_contents = file.read.chomp
    file.close
    file_contents
  end

  def parse_article(filepath)
    string = read_article("./content/articles/" + filepath)
    [
      parse_title(string),
      parse_tags(string),
      parse_date(string),
      parse_content(string)
    ]
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
