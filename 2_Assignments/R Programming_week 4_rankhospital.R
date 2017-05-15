setwd("D:/coursera/ProgrammingAssignment3")
rankhospital <- function(state, outcome, num)
{
        data <- read.csv("outcome-of-care-measures.csv", colClass="character")
        # if not using "colClass" option, death rate will be factor class and as.numberic() will get wrong data
        newstate <- unique(data[, 7])
        newoutcome <- c("heart attack", "heart failure", "pneumonia")
        if(!state %in% newstate)
        {stop("invalid state")}
        if(!outcome %in% newoutcome)
        {stop("invalid outcome")}
        
        if(outcome == "heart attack"){col <- 11}
        if(outcome == "heart failure"){col <- 17}
        if(outcome == "pneumonia"){col <- 23}
        
        newdata <- data[data$State == state, ]
        orderdata <- newdata[order(as.numeric(newdata[, col]), newdata[, 2],
                             decreasing = FALSE, na.last = NA), ]
        
        if(num == "best") num = 1
        if(num == "worst") num = nrow(orderdata)
    
        orderdata[num, 2]
}

# Sample
#>  rankhospital("MD", "heart attack", "worst")
#[1] "HARFORD MEMORIAL HOSPITAL"

#> rankhospital("NC", "heart attack", "worst")
#[1] "WAYNE MEMORIAL HOSPITAL"

#> rankhospital("WA", "heart attack", 7)
#[1] "YAKIMA VALLEY MEMORIAL HOSPITAL"
                

#> rankhospital("TX", "pneumonia", 10)
#[1] "SETON SMITHVILLE REGIONAL HOSPITAL"
                               
#> rankhospital("NY", "heart attack", 7)
#[1] "BELLEVUE HOSPITAL CENTER"
#Warning message:
#In order(as.numeric(newdata[, col]), newdata[, 2], decreasing = FALSE,  :
#NAs introduced by coercion