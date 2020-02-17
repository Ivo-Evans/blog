# 'A Bit Wise' blog

## About the blog and author

This is a statically generated site written entirely by me. To maintain it, I wrote a Ruby program called cm.rb, (where cm stands for content management). 

The aim of the site is to give beginners advice on fundamental topics in programming. I myself am not an expert - hence the title, a pun on the fact that I have learnt important information, but only a 'bit' of it. Even though I'm not an expert I still think I have knowledge to give - fresh knowledge, for instance, of what it is like to learn to program from scratch.

## About the content management system

The blog is updated via the content management system. Therefore, to make any change to the blog, you should run cm.rb and let it write your html for you. This program is made for Linux and there might be encoding problems in other operating systems. 

At time of writing, the content management system automates:
- pagination (no more than 10 articles per page) and ordering 
- creation of an archive page linking to each article in the main flow
- creation of pages for specific tags which are themselves paginated and ordered and represent alternate flows

## Using the content management system

### Adding articles

Add plaintext files to ./content/articles and then run cm.rb. This will generate new html files. index.html will always be the homepage. You do not need to delete old pages before generating new ones, but if you are deleting posts it might be a good idea to delete all html files before generating new ones so that the directory stays uncluttered.

### Naming article files

Article files begin with a number from 000 to 999, followed by the title of the article, where 000 is the first-written article and 999 is the last-written article. This convention lets content-management sort the articles to display in reverse-chronological order, but you can use any article name you want and articles will still be written into html pages.

The program is not picky about article filetypes either. .html files, .txt files, and files with no extension at all are all acceptable. It _is_ important, however, that you format their contents correctly.

### Formatting article files

Article files should be formatted as so

```
title: Your Title
tags: comma separated, tags, this list includes three tags
date: nn/nn/nn or in fact any text you like

CONTENT
<p> this is where you place the article contents</p>

<p>You should write valid HTML</p>
CONTENT
```

"title: ", "tag: " and "date: " must start a line and be lower case. Matching will occur from the ": " to the end of that line. You do not need to worry about the order in which these lines occur. 

content matching works a little differently. 
* For CONTENT markers to be matched they need to be on their own lines.
* content markers must be upper-case.
* Matching is greedy: it matches all text between the first and last valid content marker, so you may use the word CONTENT freely within the first and the last valid marker. 
* You should manually write the html tags inside the content markers. This gives you freedom to customise your articles.  
* Distinct HTML lines should be separated by one empty line, as above. When compiled, these two p tags will be touching.
* The first layer of indentation, like these p tags, should be flush with the margin. 
* The tabbing style applied by cm.rb is two spaces. This can be changed by changing the value of @tab in Compilable, ./resources/modules/compilable.rb

### Changing what appears on the 'about' page
To change this, change the contents of the about.txt file in ./content/

Everything in the file should be valid HTML, as you would like it to be rendered. There is no default heading. 

### Making changes to the page's HTML other than adding articles

content-management uses a template, found in ./resources/website-template.html, to get the shared content across html pages.

Therefore, If you want to make a change to the website other than adding an article, you should make it to website-template.html, then compile the website again with cm.rb. Make sure not to change the line that says

```
        <!-- INSERT ARTICLES HERE -->
```
or
```
        <!-- INSERT PAGINATION HERE -->
```

cm.rb needs them!

### Making changes to HTML markup for articles

The system is designed to automate the addition of articles. The markup applied to these articles is found inside Ruby scripts. Of particular interest will be Compilable, found in ./resources/modules/compilable.rb, which takes data, harvested by Readable, from ./content/, and returns arrays of valid HTML lines for Writable.
