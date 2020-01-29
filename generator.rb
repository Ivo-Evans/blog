# although this does some syntax formatting, you should rely on prettier

@article = []

def run
  title = get_title
  @article.push("  <div class=\"post-content\">")
  decide_headings
  @article.push("  </div>")
  @article.push("  <h3 class=\"expandContractButton\">Read more +</h3>")
  make_article(title)
end

def get_title
  puts 'title: '
  title = gets.chomp
  @article.push("  <h2 class=\"post-title\">#{title}</h2>")
  title
end

def decide_headings
  puts 'preamble/article text.'
  get_content
  puts 'headings? (y/n)'
  answer = gets.chomp
  puts answer
  if answer.include?('y')
    heading_train(1)
  elsif answer.include?('n')
    return
  else
    decide_headings
  end
end

def get_content 
  puts "please copy text in here, and end it with the word finish on a newline"
  
  until (text = gets.chomp) == 'finish'
    @article.push("    <p>#{text}</p>") ## this could be a switch where the user enters p, l or c for paragraph, list or code... Or there could be some shorthand for entering one or the other...
  end
end

def heading_train(depth)
  puts "please enter heading #{depth}:"
  heading = gets.chomp
  @article.push("    <h3>#{heading}</h3>")
  get_content
  get_next_heading(depth) # I think I should merge these two methods so that the user can simply enter n or the title. 
end

def get_next_heading(depth) 
  puts "are there more headings?"
  answer = gets.chomp
  if answer.include?('y')
   heading_train(depth + 1) 
  elsif answer.include?('n')
    return
  else
    puts 'couldn\'t understand, try again'
    get_next_heading(depth)
  end
end

def make_article(title)
  @article.unshift('<article>')
  @article.push('</article>')
  file = File.open("./articles/#{title[0..13]}", 'w')
  # I really don't understand, but this comment needs to be here for the program to run lol
  @article.each do |tag| 
    file.write(tag) 
    file.write("\n")
  end
  file.close
end

run
