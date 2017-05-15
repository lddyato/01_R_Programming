# Coding standards for R
1. Always use text files/text editor
2. Indent your code
 + Improves readability
 + Fixing line length (80 columns) prevents lots of nesting and very long functions
 + Suggested: Indents of 4 spaces at minimum; 8 spaces ideal
3. Limit the width of your code (80 columns?)
4. Limit the length of individual functions


# Markdown
"Markdown is a text-to-HTML conversion tool for web writers. Markdown
allows you to write using an easy-to-read, easy-to-write plain text format,
then convert it to structurally valid XHTML (or HTML)."---- John Gruber, creator of Markdown
* Created by John Gruber and Aaron Swartz
* A simplified version of "markup" languages
* Allows one to focus on writing as opposed to formatting
* Simple/minimal intuitive formatting elements
* Easily converted to valid HTML (and other formats) using existing tools
* Complete information is available at <http://daringfireball.net/projects/markdown/>
* Some background information at <http://daringfireball.net/2004/03/dive_into_markdown>

### Links
[Johns Hopkins Bloomberg School of Public Health](http://www.jhsph.edu/)
[Download R](http://www.r-project.org/)
[RStudio](http://www.rstudio.com/)

OR:

I spend so much time reading [R bloggers][1] and [Simply Statistics][2]!
[1]: http://www.r-bloggers.com/ "R bloggers"
[2]: http://simplystatistics.org/ "Simply Statistics"



# Rmarkdown
* R markdown is the integration of R code with markdown
* Allows one to create documents containing "live" R code
* R code is evaluated as part of the processing of the markdown
* Results from R code are inserted into markdown document
* A core tool in **literate statistical programming**

## Problems
* Authors	must	undertake	considerable	effort	to	put	data/results	on	the	web	
* Readers	must	download	data/results	individually	and	piece	together	which	data	go	with	which	code	sec)ons,	etc.	
* Authors/readers	must	manually	interact	with	websites	
* There	is	no	single	document	to	integrate	data	analysis	with	textual	representa)ons;	i.e.	data,	code,	and	text	are	not	linked	

# Literate statistical programming
* Original	idea	comes	from	**Don	Knuth**	
* An	article	is	a	stream	of	**text**	and	**code**
* Analysis	code	is	divided	into	text	and	code	“chunks”	
* Presentation	code	formats	results	(tables,	figures,	etc.)	
* article	text	explains	what	is	going	on	
* Literate	programs	are	**weaved**	to	produce	humanreadable	documents	and	**tangled**	to	produce	machinereadable	documents	
* Literate	programming	is	a	general	concept.	We	need	
 – A	documentation	language	
 – A	programming	language	
* The	original	**Sweave**	system	developed	by	Friedrich	Leisch	used	LaTeX	and	R	
* **knitr**	supports	a	variety	of	documentation	languages	


### Pros
* Text	and	code	all	in	one	place,	logical	order	
* Data,	results	automa)cally	updated	to	reflect	external	changes	
* Code	is	live--automa)c	“regression	test”	when	building	a	document	

### Cons
* Text	and	code	all	in	one	place;	can	make	documents	difficult	to	read,	especially	if	there	is	a	lot	of	code	
* Can	substantially	slow	down	processing	of	documents	(although	there	are	tools	to	help)	

# knitr
* An	R	package	wri\en	by	Yihui Xie	(while	he	was	a	grad	student	at	Iowa	State)	– Available	on	CRAN	
* Supports	RMarkdown,	LaTeX,	and	HTML	as	documenta)on	languages	
* Can	export	to	PDF,	HTML	
* Built	right	into	RStudio	for	your	convenience	

## Requirements
* A	recent	version	of	R	
* A	text	editor	(the	one	that	comes	with	RStudio	is	okay)	
* Some	support	packages	also	available	on	CRAN	
* Some	knowledge	of	Markdown,	LaTeX,	or	HTML	
* We	will	use	Markdown	here	

## What	is	knitr	Good	For?	
• Manuals	
• Short/medium-length	technical	documents	
• Tutorials	
• Reports	(esp.	if	generated	periodically)	
• Data	preprocessing	documents/summaries	

## What	is	knitr	NOT	Good	For?	
• Very	long	research	articles	
• Complex time-consuming	computations	
• Documents	that	require	precise	formaang	

## Notes
• knitr	will	fill	a	new	document	with	filler	text;	delete	it	
• Code	chunks	begin	with	```{r}	and	end	with	```    
• All	R	code	goes	in	between	these	markers	    
• Code	chunks	can	have	names,	which	is	useful	when	we	start	making	graphics	    
• By	default,	code	in	a	code	chunk	is	echoed,	as	will	the	results	of	the	computa)on	(if	there	are	results	to	print)	

# Processing of knitr Documents
• You	write	the	RMarkdown	document	(.Rmd)	
• knitr	produces	a	Markdown	document	(.md)	
• knitr	converts	the	Markdown	document	into HTML	(by	default)	
• .Rmd --> .md --> .html	
• You	should	NOT	edit	(or	save)	the	.md	or .html	documents	until	you	are	finished

# Setting glboal options	
• Sometimes	we	want	to	set	options	for	everycode	chunk	that	are	different	from	the	defaults	
• For	example,	we	may	want	to	suppress	all	code	echoing	and	results	output	
• We	have	to	write	some	code	to	set	these	global	op)ons	

```{r setoptions, echo=FALSE}
opts_chunk$set(echo =  FALSE, results = "hide")
# The default is  echo = TRUE and results = asis" means that the code and the results are both outputed.
##  echo=FALSE means that do not echo code, that is, the code is hided, the result is presented.
```

# Caching computations
• What	if	one	chunk	takes	a	long	)me	to	run?	
• All	chunks	have	to	be	re-computed	every	)me	you	re-knit	the	file	
• The	cache=TRUE op)on	can	be	set	on	a	chunk-by-chunk	basis	to	store	results	of	computa)on	
• AVer	the	first	run,	results	are	loaded	from	cache	

# Caching caveats
• If	the	data	or	code	(or	anything	external)	changes,	you	need	to	re-run	the	cached	code	chunks	
• Dependencies	are	not	checked	explicitly	
• Chunks	with	significant	side	effects	may	not	be	cacheable	
