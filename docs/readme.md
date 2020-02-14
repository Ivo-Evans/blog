# 'A Bit Wise' blog

## About the blog and author

This is a statically generated site written entirely by me. To maintain it, I wrote a Ruby program called content-management. Note that this program is made for Linux. 

The aim of the site is to give beginners advice on fundamental topics in programming. I myself am not an expert (hence the title, a pun on the fact that I have learnt important information, but only a 'bit' of it). However, I do not think that my relative inexperience makes me less qualified to advise beginners. Rather, I think it makes me more qualified, because those who are advanced in a field often take certain details for granted - things that a beginner just doesn't know, or has to guess at. The best teacher can be somebody who is just a little further on from the learner, and who can remember the unique challenges facing the learner. That is a role that - I hope - I will be able to fill.

## The content management system.

The blog is updated via the content management system. Therefore, to make any change to the blog, you should run content-management and let it write your html for you. 


### Adding articles

Add plaintext files to ./content/articles and then run content-management. This will generate new html files representing the pages of the blog. index.html will always be the homepage. Adding an article in this way ensures that the archive is kept up to date, that the most recent article appears first on the blog, and that no more than ten articles appear per page. It also generates and adds to tag pages. 

You do not need to delete old pages before generating new ones.

### Naming article files

Article files begin with a number from 000 to 999, followed by the title of the article, where 000 is the first-written article and 999 is the last-written article. This convention lets content-management sort the articles to display in reverse-chronological order. That said, you can use any article name you want and articles will still be written into html pages.

The program is not picky about article filetypes either. .html files, .txt files, and files with no extension at all are all acceptable. It _is_ important, however, that you format their contents correctly.

### Formatting article files

Article files should be formatted as so

```
title: Your Title
tags: comma separated, tags
date: nn/nn/nn or in fact any text you like

CONTENT
<p> this is where you place the article contents</p>

<p>You should write valid HTML</p>
CONTENT
```

"title: ", "tag: " and "date: " must start a line and be lower case. Matching will occur from the ": " to the end of that line.

content matching works differently. 
* For CONTENT markers to be matched they need to be on their own lines.
* content markers must be upper-case.
* Matching is greedy: it matches all text between the first and last valid content marker, so you may use the word CONTENT freely within the first and the last valid marker. 
* You should manually write the html tags inside the content markers. This gives you freedom to customise your articles.  
* Distinct HTML lines should be separated by one empty line, as above. When compiled, these two p tags will be touching.
* The first layer of indentation, like these p tags, should be flush with the margin. 
* The tabbing style applied by content-management is two spaces. This can be changed by changing the value of @tab in Compilable, ./resources/modules/compilable.rb

### Changing what appears on the 'about' page
To change this, change the contents of the about.txt file in ./content/

Everything in the file should be valid HTML, as you would like it to be rendered. There is no default heading. 

### Making changes to the page's HTML other than adding articles

content-management uses a template, found in ./resources/website-template.html, to generate html pages which it then inserts page-specific contents into.

Therefore, If you want to make a change to the website other than adding an article, you should make it to website-template.html, then compile the website again with content-management. Make sure not to change the line that says

```
        <!-- INSERT ARTICLES HERE -->
```
or
```
        <!-- INSERT PAGINATION HERE -->
```

content-management needs them!

### Making changes to HTML markup for articles

The system is designed to automate the addition of articles. The markup applied to these articles is found inside Ruby scripts. Of particular interest will be Compilable, found in ./resources/modules/compilable.rb, which takes data, harvested by Readable, from ./content/, and returns arrays of valid HTML lines for Writable.
