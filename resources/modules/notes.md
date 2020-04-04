CMS.rb

# -> initialize -> @article_format = Readable.read_article('./templates/article.html') # should be renamed to read_file

-> make_article_pages -> Compilable.compile_articles extra param, @article_format

Compilable.rb


Later issues:
# maybe Readable.parse_article should return a hash rather than an array. It would be better later, when you could pass the hash to compile_articles instead of separated array elements
# currently we (I) assign a multi-word id to each post, and then use that to actual effect - something to consider. Switching to dashes would be better but
  a) Have I dont that already?
  b) the js might well need to change too