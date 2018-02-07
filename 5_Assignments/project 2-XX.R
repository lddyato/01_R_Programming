## Install relative packages
if(!require(dplyr)){
        install.packages("dplyr")
        library(dplyr)
}
if(!require(ggplot2)){
        install.packages("ggplot2")
        library(ggplot2)
}
if(!require(ggmap)){
        install.packages("ggmap")
        library(ggmapy)
}
if(!require(car)){
        install.packages("car")
        library(car)
}
if(!require(maps)){
        install.packages("maps")
        library(maps)
}


## Downloading the data
if(!file.exists("data5")) dir.create("data5")
fileurl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
download.file(fileurl, destfile = "./data5/StormData.csv.bz2")
# or bunzip2("D:/coursera/data5/repdata%2Fdata%2FStormData.csv.bz2"); storm <- read.csv("D:/coursera/data5/repdata%2Fdata%2FStormData.csv")
stormdata <- read.csv(bzfile("D:/coursera/data5/repdata%2Fdata%2FStormData.csv.bz2"), as.is = TRUE, header = TRUE)
# If I use "stringAsFactors = FALSE" instead of "as.is = TRUE", then there is an error saying "unused argument (stringAsFactors = FALSE)". 
dim(stormdata)
str(stormdata)
length(unique(stormdata$EVTYPE))

## Data Processing: 
### 1. Subset relative variables the analysis would use.
substorm <- stormdata %>% 
        select(BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP, LATITUDE, LONGITUDE, STATE) %>%
        mutate(BGN_DATE = as.Date(BGN_DATE, format = "%m/%d/%Y")) %>%
        filter((PROPDMG>0 | CROPDMG>0 | INJURIES>0 | FATALITIES>0) & (BGN_DATE > "1996-01-01"))
str(substorm)
head(substorm)
tail(substorm)
some(substorm)

# storm <- stormdata[, c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP")]
# storm <- subset(stormdata, select = c("BGN_DATE", "EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP"))

length(unique(substorm$EVTYPE))
unique(substorm$PROPDMGEXP)
unique(substorm$CROPDMGEXP)

storm <- substorm %>% mutate(
        TYPE = ifelse(grepl("TORN|SPOUT|WALL", EVTYPE, ignore.case=TRUE), "TORNADO",
                      ifelse(grepl("THU|TSTM|TUN|FUNNEL|STORM|TROP|TSUN|TYPH|COASTAL", EVTYPE, ignore.case=TRUE),"STORM",
                             ifelse(grepl("HURR", EVTYPE, ignore.case=TRUE), "HURRICANE",
                                    ifelse(grepl("FIRE|SMOKE", EVTYPE, ignore.case=TRUE), "WILDFIRE",
                                           ifelse(grepl("CURR|TIDE|SURF|ROGUE|RISING|WAVES", EVTYPE, ignore.case=TRUE), "TIDES",
                                                  ifelse(grepl("LIGHTNING|LIGN|LIGHTING", EVTYPE, ignore.case=TRUE), "LIGHTNING",
                                                         ifelse(grepl("HEAT|WARM|DROUGHT|HIGH TEMP|RECORD HIGH|HOT|DRIEST", EVTYPE, ignore.case=TRUE), "HEAT",
                                                                ifelse(grepl("COLD|FREEZ|CHILL|FROST|WINT|ICE|ICY|SNOW|SLEET|BLIZZ|GLAZE|LOW TEMP|RECORD LOW|DRY",
                                                                             EVTYPE, ignore.case=TRUE), "COLD",
                                                                       ifelse(grepl("FLOOD|HIGH WATER|FLD|LAND|MUD|FLOOOD|FLOYD", EVTYPE, ignore.case=TRUE), "FLOOD",
                                                                              ifelse(grepl("HAIL", EVTYPE, ignore.case=TRUE), "HAIL",
                                                                                     ifelse(grepl("RAIN|PRECIP|SHOWER|WET", EVTYPE, ignore.case=TRUE), "RAIN",
                                                                                            ifelse(grepl("WIND|BURST|WND", EVTYPE, ignore.case=TRUE), "WIND",
                                                                                                   ifelse(grepl("DUST", EVTYPE, ignore.case=TRUE), "DUST", "OTHER"))))))))))))),
        PROPDMGEXP = ifelse(PROPDMGEXP %in% c("K", "k"), 10^3,
                                   ifelse(PROPDMGEXP %in% c("M", "m"), 10^6,
                                          ifelse(PROPDMGEXP == "B", 10^9, 0))),
        CROPDMGEXP = ifelse(CROPDMGEXP %in% c("K", "k"), 10^3,
                            ifelse(CROPDMGEXP %in% c("M", "m"), 10^6,
                                   ifelse(CROPDMGEXP == "B", 10^9, 0))),
CASUALTY = FATALITIES + INJURIES,
TOTPROPDMG = PROPDMG * PROPDMGEXP,
TOTCROPDMG = CROPDMG * CROPDMGEXP,
TOTDMG = TOTPROPDMG + TOTCROPDMG)
str(storm)
head(storm)
tail(storm)
length(unique(storm$TYPE))
unique(storm$TYPE)
unique(storm$PROPDMGEXP)
unique(storm$CROPDMGEXP)


SUMCAS <- storm %>% 
        group_by(TYPE) %>% 
        summarise(CAS = sum(CASUALTY, na.rm = TRUE)) %>%
        arrange(desc(CAS))
SUMCAS <- as.data.frame(SUMCAS)
head(SUMCAS, n = 10)
SUMCAS$TYPE <- factor(SUMCAS$TYPE, levels = SUMCAS[order(SUMCAS$CAS), "TYPE"])
ggharm <- ggplot(SUMCAS, aes(x=reorder(factor(TYPE),desc(CAS)), y=CAS, fill=CAS)) + geom_bar(stat = "identity") +
        ggtitle("TOTAL CASUALTIES CAUSED BY WEATHER") +
        theme(axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1)) +
        xlab("Event Type") + ylab("Fatalities and Injuries") + scale_fill_gradient2()
ggharm



SUMPROPDMG <- storm %>% 
        group_by(TYPE) %>% 
        summarise(SUMPROP = sum(TOTPROPDMG, na.rm = TRUE)) %>%
        arrange(desc(SUMPROP))
SUMPROPDMG <- as.data.frame(SUMPROPDMG)
head(SUMPROPDMG, n = 10)
SUMPROPDMG$TYPE <- factor(SUMPROPDMG$TYPE, levels = SUMPROPDMG[order(SUMPROPDMG$SUMPROP), "TYPE"])
ggPROPDMG <- ggplot(SUMPROPDMG[1:10,], aes(x=reorder(factor(TYPE),desc(SUMPROP)), y=SUMPROP/10^6, fill=SUMPROP)) + geom_bar(stat = "identity", col = "black") +
        ggtitle("Top 10 Most Harmful Weather Events to Property Damage") +
        theme(axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1)) + guides(fill = FALSE) +
        xlab("TYPE") + ylab("Property Damage (Millions)") +  scale_fill_gradient(low = "white", high = "pink")
ggPROPDMG


SUMCROPDMG <- storm %>% 
        group_by(TYPE) %>% 
        summarise(SUMCROP = sum(TOTCROPDMG, na.rm = TRUE)) %>%
        arrange(desc(SUMCROP))
SUMCROPDMG <- as.data.frame(SUMCROPDMG)
head(SUMCROPDMG, n = 10)
SUMCROPDMG$TYPE <- factor(SUMCROPDMG$TYPE, levels = SUMCROPDMG[order(SUMCROPDMG$SUMCROP), "TYPE"])
ggCROPDMG <- ggplot(SUMCROPDMG[1:10,], aes(x=reorder(factor(TYPE),desc(SUMCROP)), y=SUMCROP/10^6, fill=SUMCROP)) + geom_bar(stat = "identity", col = "black") +
        ggtitle("Top 10 Most Harmful Weather Events to Crop Damage") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1)) + guides(fill = FALSE) +
        xlab("TYPE") + ylab("Crop Damage (Millions)") + scale_fill_gradient2(low = "white", mid="pink", high = "lightblue")
ggCROPDMG


ggEVENT <- storm %>% filter(TYPE %in% c("TORNADO", "FLOOD", "STORM", "WIND")) %>%
        mutate(Lat = LATITUDE/100.0, Lon = -1.0*LONGITUDE/100.0)
usevmap <- ggmap(get_map("usa", zoom = 4), extent = "device") 
usevmap + stat_density2d(data=ggEVENT,
                         aes(x=Lon,y=Lat,fill=..level..,alpha=..level..,colour=TYPE), bins = 6, geom = "polygon") + 
        facet_wrap(~TYPE,ncol=2) + theme(legend.position='none') + 
        theme() + labs(title='The First Four Severe Weather distribution across the US since 1996')




--------------------------------------------------------------------
myStormData$PROPDMGEXP <- as.character(myStormData$PROPDMGEXP)
myStormData$PROPDMGEXP <- gsub("h|H", "2", myStormData$PROPDMGEXP)
myStormData$PROPDMGEXP <- gsub("k|K", "3", myStormData$PROPDMGEXP)
myStormData$PROPDMGEXP <- gsub("m|M", "6", myStormData$PROPDMGEXP)
myStormData$PROPDMGEXP <- gsub("B", "9", myStormData$PROPDMGEXP)
myStormData$PROPDMGEXP <- gsub("\\-|\\+|\\?", "0", myStormData$PROPDMGEXP)
myStormData$PROPDMGEXP <- as.numeric(myStormData$PROPDMGEXP)
myStormData$PROPDMGEXP[is.na(myStormData$PROPDMGEXP)] = 0

# Add additional column for after computation value - PROPERTYLOSS
myStormData <- mutate(myStormData, PROPERTYLOSS = PROPDMG * 10^PROPDMGEXP)

        
        
        
        
        firmapdata <- map_data("state")
secmapdata <- firmapdata
secmapdata$abbregion <- state.abb[grep(secmapdata$region, state.name)]
head(secmapdata)


ggplot(ggEVENT, aes(x = LON, y = Lat, fill = TYPE)) + stat_density2d(aes(fill=..level..,alpha=..level..,colour=TYPE), bins = 6, geom = "polygon") + 
        facet_wrap(~TYPE, nrow = 1) + theme(legend.position = "none") + theme() + labs(title="The first four event type")



 
usevmap + stat_density2d(ggEVENT, aes(x = Lon, y = Lat, colour=TYPE)) + 
        facet_wrap(~TYPE, nrow = 1) + theme(legend.position = "none") + theme() + labs(title="The first four event type")
usevmap


---------------------------------------------
ggEVMAP <- ggplot(EVMAPS, aes(x = long, y = lat, group = group, fill = TYPE)) + geom_polygon(colour = "black")
abb2state <- function(name, convert = F, strict = F){
        data(state)
        # state data doesn't include DC
        state = list()
        state[['name']] = c(state.name,"District Of Columbia")
        state[['abb']] = c(state.abb,"DC")
        
        if(convert) state[c(1,2)] = state[c(2,1)]
        
        single.a2s <- function(s){
                if(strict){
                        is.in = tolower(state[['abb']]) %in% tolower(s)
                        ifelse(any(is.in), state[['name']][is.in], NA)
                }else{
                        # To check if input is in state full name or abb
                        is.in = rapply(state, function(x) tolower(x) %in% tolower(s), how="list")
                        state[['name']][is.in[[ifelse(any(is.in[['name']]), 'name', 'abb')]]]
                }
        }
        sapply(name, single.a2s)
}

storm$FSTATE <- as.vector(unlist(abb2state(storm$STATE)))




