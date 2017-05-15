# ggplot2
* Grammar	of	Graphics by	Leland	Wilkinson	
* Written	by	Hadley	Wickham	(while	he	was	a	graduate	student	at	Iowa	State)	
* A	“third”	graphics	system	for	R	(along	with	base and	lattice)	

## What is ggplot2?

* Grammar	of	graphics	represents	and	abstraction	of	graphics	ideas/objects	
* Think	“verb”,	“noun”,	“adjective”	for	graphics	
* Allows	for	a	“theory”	of	graphics	on	which	to	build	new	graphics	and	graphics	objects	
* “Shorten	the	distance	from	mind	to	page”	

## Basic components of a ggplot2
1. A	data	frame	
2. aesthe/c mappings:	color,	size, shape	
3. geoms:	geometric	objects	like	points,	lines,	shapes.		
4. facets:	for	conditional	plots.		
5. stats:	statistical	transformation (binning,	quantiles,	smoothing).		
6. scales:	what	scale	an	aesthetic	map	uses	(example:	male	=	red,	female	=	blue).		
7. coordinate	system		

## Two workhorse functions in ggplot2 packages
* qplot (scatter, histograms, box and whisker)
```r
str(mpg)
qplot(displ, hwy, data=mpg)
qplot(displ, hwy, data=mpg, color=drv)
qplot(displ, hwy, data=mpg, color=drv, geom=c("point", "smooth")) #gray areas surrounding each trend lines indicate the 95% confidence intervals for the lines.
qplot(y=hwy, data=mpg, color=drv) #specifying the y parameter only, plots the values of the y argument in the order in which they occur in the data.
qplot(drv, hwy, data=mpg, geom="boxplot")
qplot(drv, hwy, data=mpg, geom="boxplot", color=manufacturer)
qplot(hwy, data=mpg, fill=drv)
qplot(displ, hwy, data=mpg, facets=.~drv) #1 by 3 array of plots, each is labeled at the top with the factor label (4,f, or r).
qplot(hwy, data=mpg, facets=drv~., binwidth=2)
qplot(displ, hwy, data=mpg, geom=c("point", "smooth"), facets=.~drv)
```
```r
qplot(price, data=diamonds) # Histogram
qplot(price, data=diamonds,binwidth=18497/30,fill=cut)
qplot(price, data=diamonds,geom="density")
qplot(price, data=diamonds,geom="density", color=cut)
qplot(carat, price, data=diamonds,shape=cut) # Scatter plot
qplot(carat, price, data=diamonds,color=cut)
qplot(carat, price, data=diamonds,color=cut)+geom_smooth(method="lm")
qplot(carat, price, data=diamonds,color=cut, facets=.~cut)+geom_smooth(method="lm")
```
```r
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
```

* ggplot
```r
g <- ggplot(mpg, aes(displ, hwy))
g+geom_point()
g+geom_point()+geom_smooth()
g+geom_point()+geom_smooth(method="lm")
g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv)
g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv)+ggtitle("Swirl Rules!")
g+geom_point(color="pink",size=4,alpha=1/2) # Darker circles indicate values hit by multiple data points.
g+geom_point(size=4,alpha=1/2, aes(color=drv)) 
g+geom_point(aes(color=drv))+labs(title="Swirl Rules!")+labs(x="Displacement", y="Hwy Mileage")
g+geom_point(size=2,alpha=1/2, aes(color=drv))+geom_smooth(size=4, linetype=3, method="lm", se=FALSE) 
# se=FALSE  turn off the gray shadows indicating standard errors (confidence intervals).
g+geom_point(aes(color=drv))+theme_bw(base_family="Times")
------------------------------------------------------------------------------------------------------------------
plot(myx, myy, type="l", ylim=c(-3,3)) #The outlier at (50,100) is NOT shown on the line plot.
g <- ggplot(testdat, aes(x=myx, y=myy))
g+geom_line() #display the outlier point at (50,100)
g + geom_line() + ylim(-3,3) #ggplot simply ignored the outlier point at (50,100).
g + geom_line() + coord_cartesian(ylim=c(-3,3))  # same with the plot function in base plotting system
g <- ggplot(mpg, aes(x=displ, y=hwy, color=factor(year))) # it just isn't visible yet since you didn't add a layer. If you typed g at the command line,R would return an error in red
g+geom_point()+facet_grid(drv~cyl, margins=TRUE) #  A 4 by 5 plot. The margins argument tells ggplot to display the marginal totals over each row and column
g+geom_point()+facet_grid(drv~cyl, margins=TRUE)+geom_smooth(method="lm", se=FALSE, size=2, color="black")
g+geom_point()+facet_grid(drv~cyl, margins=TRUE)+geom_smooth(method="lm", se=FALSE, size=2, color="black")+labs(x="Displacement",y="Highway Mileage",title="Swirl Rules!")
theme(): theme_gray() and theme_bw()
----------------------------------------------------------------------------------------------------------------
 g <- ggplot(diamonds, aes(depth, price))
summary(g)
g+geom_point(alpha=1/3)
cutpoints <- quantile(diamonds$carat,seq(0,1,length=4),na.rm=TRUE)
cutpoints
#       0% 33.33333% 66.66667%      100% 
#     0.20      0.50      1.00      5.01 
diamonds$car2 <- cut(diamonds$carat, cutpoints)
g <- ggplot(diamonds, aes(depth, price))
g+geom_point(alpha=1/3)+facet_grid(cut ~ car2)
g+geom_point(alpha=1/3)+facet_grid(cut ~ car2)+geom_smooth(method="lm", size=3, color="pink")
ggplot(diamonds,aes(carat,price))+geom_boxplot()+facet_grid(.~cut) 
``` 
 
 

