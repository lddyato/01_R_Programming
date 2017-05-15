# Reproducible Research
## Replication
* The	ultimate	standard	for	strengthening	scientific	evidence	is	replication	of	findings	and	conducting	studies	with independent	
 + Investigators  
 + Data	  
 + Analytical	methods	  
 + Laboratories	  
 + Instruments	  
* Replication	is	particularly	important	in	studies	that	can	impact	broad	policy	or	regulatory	decisions	

## What's wrong with Replication?
* Some	studies	cannot	be	replicated	
 – No	time,	opportunis5c	
 – No	money	
 – Unique	
* Reproducible	Research:	Make	analytic	data	and	code	available	so	that	others	may	reproduce	findings	

## How can we brige the gap?
Replication <---> Reproduciblity <---> Nothing

## Why do we need reproducible research?
* New	technologies	increasing	data	collection	throughput;	data	are	more	complex	and	extremely	high	dimensional	  
* Existing	databases	can	be	merged	into	new	“megadatabases”	  
* Computing	power	is	greatly	increased,	allowing	more	sophisticated	analyses	  
* For	every	field	“X”	there	is	a	field	“Computational	X”   

## Example
* Estimating small (but important) health effects in the presence of much stronger signals
* Results inform substantial policy decisions, affect many stakeholders
 + EPA regulations can cost billions of dollars
* Complex statistical methods are needed and subjected to intense scrutiny

<img src="https://github.com/lddyato/Reproducible-Research/blob/master/pipeline.jpg">


## What do we need?

* Analytic	data	are	available	
* Analytic	code	are	available	
* Documentation	of	code	and	data	
* Standard	means	of	distribu5on	

## Who are the players?
• Authors	
 – Want	to	make	their	research	reproducible	
 – Want	tools	for	RR	to	make	their	lives	easier	(or	at	least	not	much	harder)	 
 
• Readers	
 – Want	to	reproduce	(and	perhaps	expand	upon)	interes5ng	findings	
 – Want	tools	for	RR	to	make	their	lives	easier	
 
## Chanllenges
* Authors	must	undertake	considerable	effort	to	put	data/results	on	the	web	(may	not	have	resources	like	a	web	server)	
* Readers	must	download	data/results	individually	and	piece	together	which	data	go	with	which	code	sections,	etc.	
* Readers	may	not	have	the	same	resources	as	authors	
* Few	tools	to	help	authors/readers	(although	toolbox	is	growing!)	

## In Reality...
• Authors	
 – Just	put	stuff	on	the	web	
 – (Infamous)	Journal	supplementary	materials	
 – There	are	some	central	databases	for	various	fields	(e.g.	biology,	ICPSR)	  
 
• Readers	
 – Just	download	the	data	and	(try	to)	figure	it	out	
 – Piece	together	the	socware	and	run	it	
 
## Literate	(Statistical)	Programming	
• An	article	is	a	stream	of	**text**	and	**code**	
• Analysis	code	is	divided	into	text	and	code	“chunks”	
• Each	code	chunk	loads	data	and	computes	results	
• Presentation	code	formats	results	(tables,	figures,	etc.)	
• Article	text	explains	what	is	going	on	
• Literate	programs	can	be	**weaved**	to	produce	human-readable	documents	and	tangled	to	produce	machine-readable	documents	

Literate	programming	is	a	general	concept	that	requires	
 1. A	documentation	language	(human	readable)	
 2. A	programming	language	(machine	readable)	

### Sweave
• Sweave	uses	LATEX	and	R	as	the	documenta5on	and	programming	languages	
• Sweave	was	developed	by	Friedrich	Leisch(member	of	the	R	Core)	and	is	maintained	by	R	core	
• Main	web	site:	<http://www.statistik.lmu.de/~leisch/Sweave>

### Sweave Limitations
• Sweave	has	many	limitations	
• Focused	primarily	on	LaTeX,	a	difficult	to	learn	markup	language	used	only	by	weirdos
• Lacks	features	like	caching,	multiple	plots	per	chunk,	mixing	programming	languages	and	many	other	technical	items	
• Not	frequently	updated	or	very	actively	developed	

### knitr
• knitr	is	an	alternative	(more	recent)	package	
• Brings	together	many	features	added	on	to	Sweave	to	address	limitations	
• knitr	uses	R	as	the	programming	language	(although	others	are	allowed)	and	variety	of	documentation	languages	
 + LaTeX,	Markdown,	HTML	
• knitr	was	developed	by	Yihui Xie	(while	a	graduate	student	in	statistics	at	Iowa	State)	
• See	<http://yihui.name/knitr/>


## Summary
• Reproducible	research	is	important	as	a	**minimum	standard**,	particularly	for	studies	that	are	difficult	to	replicate	
• Infrastructure	is	needed	for	**creating**	and	**distributing**	reproducible	documents,	beyond	what	is	currently	available	
• There	is	a	growing	number	of	tools	for	creating	reproducible	documents	




