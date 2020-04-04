# frozen_string_literal: true

# receives filepath or file contents and selects part/s of it.
module Readable
  def self.read_article(filepath)
    file = open(filepath, 'r')
    file_contents = file.read.chomp
    file.close
    file_contents
  end

  def self.parse_article(filepath)
    string = read_article('./content/articles/' + filepath)
    {
      title: parse_title(string),
      tags: parse_tags(string),
      date: parse_date(string),
      content: parse_content(string)
    }
  end

  def self.parse_title(string)
    title = string[/(?<=^title: ).*$/]
    title || ''
  end

  def self.parse_tags(string)
    tags = string[/(?<=^tags: ).*$/]
    tags ? tags.split(', ') : ''
  end

  def self.parse_date(string)
    date = string[/(?<=^date: ).*$/]
    date || ''
  end

  def self.parse_content(string)
    content = string[/(?<=CONTENT\n)[\w\W]*(?=\nCONTENT)/]
    content ? content.split("\n\n") : ''
  end
end
