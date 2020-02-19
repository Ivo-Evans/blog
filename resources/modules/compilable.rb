# frozen_string_literal: true

# receives array of strings and returns array of strings in valid HTML
module Compilable
  @tab = '  '

  def self.compile_article(title, tags, date, content, namer) 
    # you could receive an array here and just map it. The tags map would then be a nested flat-map or something
    tags = tags.map { |tag| "<a href=\"#{namer["tag-#{tag}", 0]}\">#{tag}</a>"}
    # tags = tags.map { |tag| "<a href=\"./tag-#{tag}.html\">#{tag}</a>" }
    lines = [
      @tab * 2 + '<article class="post">',
      @tab * 3 + "<span class=\"post-title-bar\"><h2 id=\"#{title}\" class=\"post-title\">#{title}</h2><p class=\"meta-info\">#{date}<br>#{tags.join(', ')}</p></span>",
      @tab * 3 + '<div class="post-content">'
    ]

    content.each { |element| lines.push(@tab * 4 + element) }

    lines + [
      @tab * 4 + '<img class="fade" src="./resources/bottom-fade.png" alt="an image that adds a fade effect to the bottom layer of collapsed text">',
      @tab * 3 + '</div>',
      @tab * 3 + '<h3 class="expandContractButton">Read more +</h3>',
      @tab * 2 + '</article>'
    ]
  end

  def self.compile_archive(titles, namer)
    titles.each_with_index do |e, i|
      titles[i] = @tab * 2 + "<p><a class=\"archive-link\"href=\"#{namer['index', i / 10]}##{e}\">#{e}</a></p>"
    end
  end

  def self.compile_pagination(this_n, total_n, namer, page_type)
    (0..total_n - 1).map do |e|
      address = namer[page_type, e]
      if e == this_n
        @tab * 3 + "<h3><a class=\"current-page\" href=\"#{address}\">#{e}</a></h3>"
      else
        @tab * 3 + "<h3><a class=\"non-current-page\" href=\"#{address}\">#{e}</a></h3>"
      end
    end
  end
end
