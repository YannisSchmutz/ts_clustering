setwd("~/Documents/BFH/Timeserie clustering/04_Code") #change this

library(quantmod)
library(openxlsx)
library(xts)
library(RCurl)


# Get the S&P 500 companys' information
download = getURL("https://raw.githubusercontent.com/datasets/s-and-p-500-companies/master/data/constituents.csv")
write.csv(download, file ="Infos")
SP500 <- read.csv(text=download)
head(SP500)

# Drop some companies due to download errors
SP500 <- SP500[-which(SP500$Symbol %in% 
                       c("APC","AET", "ANDV", "BF.B", "BHGE","BBT", "BRK.B", "CSCO", 
                         "FCX","HRS","HCP","MON","UA","WELL", "ISRG",
                         "CA", "CSRA", "DPS", "DWDP","EVHC", "ESRG","ESRX", "GGP", 
                         "LUK", "LLL", "KORS", "NOC", "NFX", "NFLX",
                         "NVR", "PX", "RHT","COL", "SCG", "SYMC", 
                         "TMK", "TSS","TWX", "VIAC", "WYN", "XL")),]
write.xlsx(SP500, file = "SP500_Infos.xlsx")

# Acquire stock price information with quantmod package and yahoo api
# change the date if you need more historical data
stock_price <- list()
stock_name <- NULL
for(ticker in SP500$Symbol){
  print(ticker)
  stock <- getSymbols(ticker, src='yahoo',from = '2017-12-31', auto.assign = F)
  stock_price <- c(stock_price,list(stock))
  stock_name <- c(stock_name,ticker)
}
names(stock_price) <- stock_name

# I get a list of data.frames

# function to clean each data.frame
transform_df <- function(df){
  df <- fortify.zoo(df)
  int <- grep("Open", colnames(df))
  df$Symbol <- gsub(".Open", "", colnames(df)[int])
  colnames(df) <- c("Date","Open", "High", "Low", "Close", "Volume", "Adjusted", "Symbol")
  df <- df[c("Symbol", "Date", "Open", "High", "Low", "Close", "Volume", "Adjusted")]
  return(df)
}

# row bind the data for each company, i.e append the data 
# you can also choose another format
data <- transform_df(stock_price[[1]])
for (i in 2:length(names(stock_price))) {
  print(i)
  data1 <- transform_df(stock_price[[i]])
  data <- rbind(data, data1)
}

# write the data in an excel file
write.xlsx(data, file = "SP500_Stock_Prices.xlsx")

