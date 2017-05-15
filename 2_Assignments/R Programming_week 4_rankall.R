setwd("D:/coursera/ProgrammingAssignment3")
rankall<- function(outcome, num = "best")
{
        data <- read.csv("outcome-of-care-measures.csv", colClass="character")
        # if not using "colClass" option, death rate will be factor class and as.numberic() will get wrong data
        newstate <- sort(unique(data[, 7]))
        newoutcome <- c("heart attack", "heart failure", "pneumonia")
        
        if(!outcome %in% newoutcome)
        {stop("invalid outcome")}
        
        if(outcome == "heart attack"){col <- 11}
        if(outcome == "heart failure"){col <- 17}
        if(outcome == "pneumonia"){col <- 23}
        
        hospital <- character(0)
        
        for (i in seq_along(newstate)){
                newdata <- data[data$State == newstate[i], ]
                orderdata <- newdata[order(as.numeric(newdata[, col]), newdata[, 2],
                                   decreasing = FALSE, na.last = NA), ]
                if(num == "best") num = 1
                if(num == "worst") num = nrow(orderdata)
                hospital[i] <- orderdata[num, 2]
        }
                
        data.frame(hospital=hospital, state=newstate)
}
        
# Sample 
#> head(rankall("heart attack", 20), 10)
#hospital state
#1                                 <NA>    AK
#2       D W MCMILLAN MEMORIAL HOSPITAL    AL
#3    ARKANSAS METHODIST MEDICAL CENTER    AR
#4  JOHN C LINCOLN DEER VALLEY HOSPITAL    AZ
#5                SHERMAN OAKS HOSPITAL    CA
#6             SKY RIDGE MEDICAL CENTER    CO
#7              MIDSTATE MEDICAL CENTER    CT
#8                                 <NA>    DC
#9                                 <NA>    DE
#10      SOUTH FLORIDA BAPTIST HOSPITAL    FL