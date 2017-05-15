# Exploratory Data Analysis
# Base Plotting System

* The core plotting and graphics engine in R is encasulated in the following two packages

 + **graphics**: contains plotting functions for the ‘base’ graphing system, **`plot`, `boxplot`** and many others  

 + **grDevices**: contains all the code implementing the various graphics device, including **X11, PDF, PostScript, PNG, etc**

* The lattice plotting system is implementd using the following packages

 + **lattice**: contains code for producing Trellis graphics, which are independent of the ‘base’ graphics system; including functions like **`xyplot, bwplot, levelplot`**     

 + **grid**: implements a different graphing system independent of the ‘base’ system; the lattice package builds on top of grid; we seldom call functions from grid package directly.

## Base Graphics

Base graphics are used most commonly and are a very powerful system for creating 2-D graphics
There are two phases to creating a base plot
 + Initializing a new plot
 + Annotating (adding to) an existing plot

```r
# Simple Base Graphcs: histogram
par(mfrow = c(1,1))
library(datasets)
hist(airquality$Ozone)
# Simple Base Graphics: scatterplot
with(airquality, plot(Wind, Ozone))
# Simple Base Graphics: boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = 'month', ylab = 'Ozone(ppb)')
boxplot(Ozone~Month, airquality, xlab="Month", ylab="Ozone (ppb)",col.axis="blue",col.lab="red")
```
## Some important Base graphics parametes
Many base plotting functions share a set of parameters. Here are a few key ones:
* `pch`: the plotting symbol (default is open circle)    
* `lty`: the line type (default is solid line), can be dashed, dotted, etc   
* `lwd`: the line width, specified as an integer multiple    
* `col`: the plotting color, specified as a number, string, or hex code     
* `colors()` function gives you a vector of colors by name      
* `xlab`: character string for the x-axis label     
* `ylab`: character string for the y-axis label    

**`par()` function** is used to specify global graphics parameters that affect all plots in an R session
These parameters can be overridden when specified as arguments to specific plotting functions.
* `las`: the orientation of the axis labels on the plotting   
* `bg`: the background color (transparent) 
* `fg`: the foreground color   
* `mar`: the margin size # The numbers are assigned clockwise starting at the bottom. The default for the inner margin is c(5.1, 4.1, 4.1, 2.1)    
* `oma`: the outer margin size   
* `mfrow`: number of plot per row, column(plots are filled row-wise)   
* `mfcol`: number of plot per row, column(plots are filled column-wise)   
* `dev.off or plot.new` reset to the defaults   

## Base Plotting Functions   

* `plot`: make a scatter plot, or other type of plot depending on the class of the object being plotted
* `lines`: add lines to a plot, given a vector x values and a vector of y values, just connects the dots   
* `points`: add points to a plot   
* `text`: add text labels to a plot using specified x, y coordinates   
* `title`: add annotations to x, y axis labels, title, subtitle, outer margin   
* `mtext`: add arbitrary text to the margins (inner or outer)of the plot   
* `axis`: add axis ticks/labels   

```r
library(datasets)
with(airquality, plot(Wind, Ozone, main = 'Ozone and Wind in New York City'), type = 'n')
with(subset(airquality, Month == 5), points(Wind, Ozone, col = 'blue'))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = 'red'))
legend('topright', pch = 1, col = c('blue', 'red'), legend = c('May', 'Other months'))
with(airquality, plot(Wind, Ozone, main = 'Ozone and Wind in New York City'), pch = 5)
model <- lm(Ozone ~ Wind, data = airquality)
abline(model, lwd = 2)
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(2, 0, 2, 0)) # bottom left top right
with(airquality, {
        plot(Wind, Ozone, main = 'Ozone and Wind')
        plot(Solar.R, Ozone, main = 'Ozone and Solar.R')
        plot(Temp, Ozone, main = 'Ozone and temperature')
        mtext('Ozone and Weather in New York City', outer = TRUE)
})# 1 row and 3 columns with mtext
```
