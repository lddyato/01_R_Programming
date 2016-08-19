Data Types - Part 1
===================

Objects
-------

* Character
* Numeric
* Integer
* Complex
* Logical (true/false)

The most basic object is a vector:

* A vector can only contain objects of the same class
* The one exception is a list

Empty vectors can be created with the vector() function.

Numbers
-------

* Numbers in R are generally treated as numeric objects (i.e. double precision real numbers)
* If you explicitly want an integer you need to specify the L suffix
* There is a special number called Inf which represents infinity
* The value NaN represents an undefined value

Attributes
----------

R objects can have attributes

* names, dimnames
* dimensions (e.g. matrices, arrays)
* class
* length
* other user-defined attributes/metadata

Attributes of an object can be access using the attributes() function.

Entering input
--------------

At the R prompt we type expressions. The <- symbol is the assignment operator.

	> x <- 1
	> print(x)
	[1] 1
	> x
	[1]1
	> msg <- "hello"

The [1] indicates that x is a vector.

The grammar of the language determines wether an expression is complete or not.

	> x <- ## incomplete expression

The # comment begins a comment.

Printing
--------

	> x <- 1:5
	[1] 1 2 3 4 5
	
The : operator is used to create integer sequences.

	
Data Types - Part 2
===================

Creating vectors
----------------

The c() function (concatenate) can be used to create vectors of objects:

	> x <- c(0.5, 0.6)      # numeric
	> x <- c(TRUE, FALSE)   # logical
	> x <- c(T, F)          # logical
	> x <- c("a", "b", "c") # character
	> x <- c(9:29)          # integer
	> x <- c(1+0i, 2+4i)    # complex

Using the vector function:

	> x <- vector("numeric", length = 10)
	> x
	[1] 0 0 0 0 0 0 0 0 0 0 0


Mixing Objects
--------------

What about the following?

	> y <- c(1.7, "a") # character, 1.7 is converted into "1.7"
	> y <- c(TRUE, 2) # numeric, TRUE is converted into number (1)
	> y <- c("a", TRUE) # character, TRUE is converted to "TRUE"

Explicit Coercion
-----------------

Object can be explicitly coerced from one class to another using the as.* functions, if available.

	> x <- 0:6
	> class(x)
	[i] "integer"
	> as.numeric(x)
	[1] 0 1 2 3 4 5 6
	> as.logical(x)
	[1] FALSE TRUE TRUE TRUE TRUE TRUE TRUE
	> as.character(x)
	[1] "0" "1" "2" "3" "4" "5" "6"

Explicit Coercion
-----------------

Nonsensical coercion results in NAs:

	> x <-c("a", "b", "c")
	> as.numeric(x)
	[1] NA NA NA
	Warning message:
	NAs introduced by coercion
	> as.logical(x)
	[1] NA NA NA
	as.complex(x)
	[1] 0+0i 1+0i 3+0i 4+0i 5+0i 6+0i

Matrices
--------

Matrices are vectors with a dimension attribute. The dimension attribute is itself an integer vector of length 2 (nrow, ncol).

	> m<- matrix(nrow=2, ncol=3)
	> m
	     [,1] [,2] [,3]
	[1,]   NA   NA   NA
	[2,]   NA   NA   NA
	> dim(m)
	[1] 2 3
	> attributes(m)
	$dim
	[1] 2 3

Matrices are constructed _column-wise_, so entries can be thought of starting in the "upper left" corner and running down the columns.

	> m <- matrix(1:6, nrow = 2, ncol = 3)
	> m
	     [,1] [,2] [,3]
	[1,]    1    3    5
	[2,]    2    4    6

Matrices can also be created directly from vectors by adding a dimension attribute.

	> m <- 1:10
	> m
	[1]  1 2 3 4 5 6 7 8 9 10
	> dim(x) <- c(2, 5)
	> m
	     [,1] [,2] [,3] [,4] [,5]
	[1,]    1    3    5    7    9
	[2,]    2    4    6    8   10

Matrices are also commonly created by _column-bining_ or _row-binding_ with cbind() and rbind().

	> x <- 1:3
	> y <- 10:12
	cbind(x, y)
	     x  y
	[1,] 1 10
	[2,] 2 11
	[3,] 3 12
	> rbind(x, y)
	  [,1] [,2] [,3]
	x    1   2    3
	y   10  11   12

Lists
-----

Lists are a special type of vector that can contain elements of different classes. Lists are a very important data type in R and you should get to know them well.

	> x <- list(1, "a" TRUE, 1 + 4i)
	> x
	[[1]]
	[1] 1
	
	[[2]]
	[1] "a"
	
	[[3]]
	[1] TRUE
	
	[[4]]
	[1] 1+4i



Data Types - Part 3
===================

Factors
-------

Factors are used to represent categorical data. Factors can be unordered or ordered. one can think of a factor as an integer vector where each integer has a label.

* Factors are treated specially by R modeling functions like lm() and glm()
* Using factors with labels is better than using integers because factors are self-describing; having a variable that has values "Male" and "Female" is better than a variable that has values 1 and 2

Examples:

	> x <- factor(c("yes", "yes", "no", "yes", "no"))
	> x
	[1] yes yes no yes no
	Levels: no yes
	> table(x)
	x
	no yes
	 2   3
	> unclass(x)
	[1] 2 2 1 2 1
	attr(, "levels")
	[1] "no "yes"

The order of the levels can be set using the levels argument to factor(). This can be important in linear modeling because the first level is used as the baseline level.

	> x <- factor(c("yes", "yes", "no", "yes", "no"),
			levels = c("yes", "no"))
	> x
	[1] yes yes no yes no
	Levels: yes no

Missing values
--------------

Missing values are denoted by NA or NAN for undefined mathematical operations.

* is.na() is used to test if they are NA (missing values)
* is.nan() is used to test for NaN (not a number)
* NA values have  a class also, so there are integer NA and character NA etc
* a NaN value is also NA but the converse is not true

Examples:

	> x <- c(1, 2, NA, 10, 3)
	> is.na(x)
	[1] FALSE FALSE TRUE FALSE FALSE
	> is.nan(x)
	[1] FALSE FALSE FALSE FALSE FALSE
	> x <- c(1, 2, NaN, NA, 4)
	is.na(x)
	[1] FALSE FALSE TRUE TRUE FALSE
	> is.nan(x)
	[1] FALSE FALSE TRUE FALSE FALSE

Data Frame
----------

Data frames are used to store tabular data.

* They are represented as a special type of list where every element of the list has to have the same length
* Each element of the list can be thought of as a column and the length of each element of the list is the number of rows
* Unlike matrices, data frames can store different classes of objects in each column (just like lists); matrices must have every element be the same class
* Data frames also have a special attributes called row.names
* Data frames are usually created by calling read.table() or read.csv()
* Can be converted to a matrix by calling data.matrix()

Examples:

	> x <- data.frame(foo = 1:4, bar = c(T,T,F,F))
	> x
	  foo   bar
	1   1  TRUE
	2   2  TRUE
	3   3 FALSE
	4   4 FALSE
	> nrow(x)
	[1] 4
	> ncol(x)
	[1] 2

Names
-----

R objects can also have names, which is very useful for writing readable code and self-describing objects.

	> x <- 1:3
	> names(x)
	NULL
	> names(x) <- c("foo", "bar", "norf")
	> x
	foo bar norf
	  1   2    3
	> names(x)
	[1] "foo" "bar" "norf"

Lists can also have names

	> x <- list(a = 1, b = 2, c = 3)
	> x
	$a
	[1] 1
	
	$b
	[1] 2
	
	$c
	[1] 3

And matrices:

	> m <- matrix(1:4, nrow = 2, ncol = 2)
	> dimnames(m) <- list(c("a", "b"), c("c", "d"))
	> m
	  c d
	a 1 3
	b 2 4

Summary
-------

* atomic classes: numeric, logical, character, integer, complex
* vectors, lists
* factors
* missing values
* data frames
* names


The str() Function
==================

Compactly display the internal structure of an R object.

* A diagnostic function and an alternative to 'summary'
* It is especially ell suited to compactly display the ( abbreviated) contents of (possibly nested) lists
* Roughly one line per basic object

str() answers the question: what's in an object?


Functions
---------

	> str(str)
	function (object, ...)

	> str(lm)
	function (formula, data, subset, weights, na.action, method = "qr", model = TRUE, 
	    x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, contrasts = NULL, 
	    offset, ...)  

	> str(ls)
	function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE, 
	    pattern)  


Vectors
-------

	> x <-rnorm(100, 2, 4)
	> summary(x)
	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
	 -8.647  -0.632   1.874   2.215   4.839  13.450 
	> str(x)
	 num [1:100] 0.9986 -6.5211 3.4636 0.5328 0.0474 ...


Factors
-------

	> f <-gl(40, 10)
	> str(f)
	 Factor w/ 40 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
	> summary(f)
	 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 
	10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 
	27 28 29 30 31 32 33 34 35 36 37 38 39 40 
	10 10 10 10 10 10 10 10 10 10 10 10 10 10 


Data Frames
-----------

	> library(datasets)
	> head(airquality)
	  Ozone Solar.R Wind Temp Month Day
	1    41     190  7.4   67     5   1
	2    36     118  8.0   72     5   2
	3    12     149 12.6   74     5   3
	4    18     313 11.5   62     5   4
	5    NA      NA 14.3   56     5   5
	6    28      NA 14.9   66     5   6
	> str(airquality)
	'data.frame':	153 obs. of  6 variables:
	 $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
	 $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
	 $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
	 $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
	 $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
	 $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...


Matrix
------

	> m <- matrix(rnorm(100), 10, 10)
	> str(m)
	 num [1:10, 1:10] 1.201 0.712 -0.118 -0.581 -0.467 ...
	> m[, 1]
	 [1]  1.2012138  0.7118305 -0.1178031 -0.5812110 -0.4673343 -0.5950841
	 [7]  0.4184978  1.8155424 -1.6733037 -0.7371094


Lists
-----

	> s <- split(airquality, airquality$Month)
	> str(s)
	List of 5
	 $ 5:'data.frame':	31 obs. of  6 variables:
	  ..$ Ozone  : int [1:31] 41 36 12 18 NA 28 23 19 8 NA ...
	  ..$ Solar.R: int [1:31] 190 118 149 313 NA NA 299 99 19 194 ...
	  ..$ Wind   : num [1:31] 7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
	  ..$ Temp   : int [1:31] 67 72 74 62 56 66 65 59 61 69 ...
	  ..$ Month  : int [1:31] 5 5 5 5 5 5 5 5 5 5 ...
	  ..$ Day    : int [1:31] 1 2 3 4 5 6 7 8 9 10 ...
	 $ 6:'data.frame':	30 obs. of  6 variables:
	  ..$ Ozone  : int [1:30] NA NA NA NA NA NA 29 NA 71 39 ...
	  ..$ Solar.R: int [1:30] 286 287 242 186 220 264 127 273 291 323 ...
	  ..$ Wind   : num [1:30] 8.6 9.7 16.1 9.2 8.6 14.3 9.7 6.9 13.8 11.5 ...
	  ..$ Temp   : int [1:30] 78 74 67 84 85 79 82 87 90 87 ...
	  ..$ Month  : int [1:30] 6 6 6 6 6 6 6 6 6 6 ...
	  ..$ Day    : int [1:30] 1 2 3 4 5 6 7 8 9 10 ...
	 $ 7:'data.frame':	31 obs. of  6 variables:
	  ..$ Ozone  : int [1:31] 135 49 32 NA 64 40 77 97 97 85 ...
	  ..$ Solar.R: int [1:31] 269 248 236 101 175 314 276 267 272 175 ...
	  ..$ Wind   : num [1:31] 4.1 9.2 9.2 10.9 4.6 10.9 5.1 6.3 5.7 7.4 ...
	  ..$ Temp   : int [1:31] 84 85 81 84 83 83 88 92 92 89 ...
	  ..$ Month  : int [1:31] 7 7 7 7 7 7 7 7 7 7 ...
	  ..$ Day    : int [1:31] 1 2 3 4 5 6 7 8 9 10 ...
	 $ 8:'data.frame':	31 obs. of  6 variables:
	  ..$ Ozone  : int [1:31] 39 9 16 78 35 66 122 89 110 NA ...
	  ..$ Solar.R: int [1:31] 83 24 77 NA NA NA 255 229 207 222 ...
	  ..$ Wind   : num [1:31] 6.9 13.8 7.4 6.9 7.4 4.6 4 10.3 8 8.6 ...
	  ..$ Temp   : int [1:31] 81 81 82 86 85 87 89 90 90 92 ...
	  ..$ Month  : int [1:31] 8 8 8 8 8 8 8 8 8 8 ...
	  ..$ Day    : int [1:31] 1 2 3 4 5 6 7 8 9 10 ...
	 $ 9:'data.frame':	30 obs. of  6 variables:
	  ..$ Ozone  : int [1:30] 96 78 73 91 47 32 20 23 21 24 ...
	  ..$ Solar.R: int [1:30] 167 197 183 189 95 92 252 220 230 259 ...
	  ..$ Wind   : num [1:30] 6.9 5.1 2.8 4.6 7.4 15.5 10.9 10.3 10.9 9.7 ...
	  ..$ Temp   : int [1:30] 91 92 93 93 87 84 80 78 75 73 ...
	  ..$ Month  : int [1:30] 9 9 9 9 9 9 9 9 9 9 ...
	  ..$ Day    : int [1:30] 1 2 3 4 5 6 7 8 9 10 ...
