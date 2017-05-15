
# Graphics Devies
A graphics device is something where you can make a plot 
 + A window on your computer(screen device)
 + A PDF file(file device)
 + A PNG or JPEG file(file device)
 + A scalable vector graphics (SVG) file(file device)
  
## Screen devices 
 + Mac **`quartz()`**
 + Windows **`windows()`**
 + Unix/Linux **`xll()`**
 
## Graphics FIle Devices   
There are two basic types of file devices: **`vector`** and **`bitmap`**
 + **Vector** formats: 
    + `pdf`: useful for line-type graphics, resizes well, usually portable, not efficient if a plot has many objects or points
    + `svg`: XML- based scalable vector graphics; supports animation and interactive, potentially useful for web-based plots
    + `win.metafile`: Windows metafile format(only on Windows)
    + `postscript`: older format, also resizes well, usually portable, can be used to create encapsulated postscript files; Windows systems ofen don’t have a postscript viewer
 + **bitmap** formats: 
    + `png`: bitmapped format, good for line drawings or images with solid color, uses lossless compression(like the old GIF format), most web browers can read this format natively, good for plotting many many points, does nor resize well
    + `jpeg`: good for photographs or natural scenes, uses lossy compression, good for plotting many many many points, does not resize well, can be read by almost any computer and any web brower, not great for line drawings
    + `tiff`: Creates bitmap files in the TIFF format; supprots lossless compression
    + `bmp`: a native Windows bitmapped format

## Multiple Open Graphics Devices
It is possible to open multiple graphics devices (screen, file, or both)   
Plotting can only occur on one graphics device at a time   
The currently active graphics device can be found by calling **dev.cur()**    
Every open grphics device is assigned an integer>=2    
You can change the active graphics device with **dev.set(<integer>)** where integer is the number associated with the graphics device you want to switch to  

## How does a plot get created    
There are two basic approaches to plotting. 
* The first is most common:
 + Call a plotting function like `plot, xyplot, qplot`
 + The plot appears on the screen device
 + Annotate plot if necessary
 + Enjoy
```r
library(datasets)
with(faithful, plot(eruption, waiting))
title(main = "Old Faithful Geyser data")
```
* The second approach to plotting is most commonly used for file devices:
 + Explicity lauch a graphics device
 + Call a plotting function to make a plot
 + Annotate plot if necessary
 + Explicitly close graphics device with **`dev.off()`**(this is very important!!!!)

```r
if(!file.exists('figures')) dir.create('figures')
pdf('./figures/myplot.pdf')
with(pollution, plot(pm25, latitude))
title(main = 'Ozone and Wind')
dev.off() # close the PDF file device
```

## Copy plots 
 - **`dev.copy`**: copy a plot from one device to another 
 - **`dev.copy2pdf`**: specifically copy a plot to a PDF file.
```r
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = 'Old Faithful Geyser data')
dev.copy(png, file = './figures/greyserplot.png')
dev.off()
```
