setwd("D:/coursera/ProgrammingAssignment3")
best <- function(state, outcome)
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
        indexmin <- which.min(as.numeric(newdata[, col]))
        newdata[indexmin, 2]
        }
#> best("SC", "heart attack")
#[1] "MUSC MEDICAL CENTER"

#> best("NY", "pneumonia")
#[1] "MAIMONIDES MEDICAL CENTER"

#> best("AK", "pneumonia")
#[1] "YUKON KUSKOKWIM DELTA REG HOSPITAL"