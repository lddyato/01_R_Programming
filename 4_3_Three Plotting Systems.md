# Exploratory Data Analysis
## Three plotting systems in R

* The basic plotting system
 + ’Artist’s palette’ model
 + Start with blank canvas and build up from there
 + Start with plot function (or similar)
 + Use annotation functions to add/modify(`text, lines, points, axis`)
 + (Pros) Convenient, mirrors how we think of building plots and analysis  
 + (Cons) Can’t go back one plot has started(i.e. to adjust margins)   
 + (Cons) Difficult to ‘translate’ to others once a new plot has been created   
 + (Cons) Plot is just a series of R commands   
 ```r
 library(datasets)
 data(cars)
 with(cars, plot(speed, dist))
```
* The Lattive system
 + (Pros) Plots are created with a single functin cal (`xyplot`, `bwplot`, etc)   
 + (Pros) Most useful for conditioning types of plots: looking at how y changes with x cross levels of z   
 + (Pros) Things like margins/spacing set automatically because entire is specified at once    
 + (Pros) Good for putting many many plots on a screen   
 + (Cons)Sometimes arkward to specify an entire plot in a single function call   
 + (Cons)Annotation in plot is not especially intuitive   
 + (Cons)Use of panel functions and subscripts difficult to wield and requires intense preparation.    
 + (Cons)Cannot ‘add’ to the plot once it is created    
```r
library(lattice)
state <- data.frame(state.x77, region =  state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1)) # 1 row and 4 columns
```

* The ggplot2 system
 + Splits the difference between base and lattive in a number of ways
 + Automatically deals with spacing, text, titles but also allows you to annotate by ‘adding’ to a plot
 + Superficial similarity to lattice but generaly easier/more intuitive to use
 + Default mode makes many choices for you (but you can still customize to your heart’s desire)
```r
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)
```

**Summary**

**Base:** ‘artist’s palette’ model  
**Lattice:** Entire plot specified by one function; conditioning  
**ggplot2:** Mixed elements of Base and Lattice   
