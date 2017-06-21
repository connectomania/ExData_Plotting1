  #############################################################################
  # READ FILE
  #############################################################################
  
  data.file <- "./household_power_consumption.txt"
  classes <- c("character", "character", "numeric", "numeric", "numeric",
               "numeric", "numeric", "numeric", "numeric")
  bigdat <- read.table(data.file, header=T, sep=";", na.strings = "?", 
                       colClasses = classes)
  names(bigdat) <- tolower(names(bigdat))
  
  #############################################################################
  # ORGANIZE DATA
  #############################################################################
  
  library(dplyr)
  
  skinny <- filter(bigdat, date %in% c("1/2/2007","2/2/2007")) %>% 
      mutate(datetime = paste(date, time, sep=" ")) %>%
      select(-date, -time) %>%
      select(datetime, everything()) 
  skinny$datetime <- strptime(skinny$datetime, format = "%d/%m/%Y %H:%M:%S")
  
  rm("bigdat") # clear space in memory
  
  #############################################################################
  # CREATE PLOT
  #############################################################################
  
  png("./plot3.png", width=480, height=480)
  
  with(skinny, {
      plot(datetime, sub_metering_1, type = "l", col = "black",
           xlab = "", ylab = "Energy sub metering" )
      lines(datetime, sub_metering_2, type = "l", col = "red")
      lines(datetime, sub_metering_3, type = "l", col = "blue")
      legend("topright", 
             legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
             lty = 1, lwd = 2, col = c("black", "red", "blue"))
  }) 
  
  dev.off()
  
  
  