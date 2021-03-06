library(readstata13)
library(plyr)

args <- commandArgs(trailingOnly = TRUE)
dir_path <- args[1]
city_name <- args[2]
file_name <- args[3]
state_abbr <- args[4]

if (substr(file_name,nchar(file_name)-3+1,nchar(file_name)) == "dta") {
  city<-read.dta13(file_name)
  vars<-c("autostud_street", "ed", "type", "block","hn")
  names(city)<-tolower(names(city))
  city30<-city[vars]
  city30<-plyr::rename(city30, c(block="Mblk", autostud_street="fullname"))  
} else {
  city<-read.csv(file_name)
  vars<-c("overall_match", "ed", "type", "block","hn")
  names(city)<-tolower(names(city))
  city30<-city[vars]
  city30<-plyr::rename(city30, c(block="Mblk", overall_match="fullname"))
}
 
city<-read.dta13("Z:\\Projects\\1940Census\\SanAntonio\\StataFiles_Other\\1930\\SanAntonioTX_StudAuto.dta")
vars<-c("autostud_street", "ed", "type", "block","hn")
names(city)<-tolower(names(city))
city30<-city[vars]
city30$state<-"TX"
city30$city<-"SanAntonio"
city30<-plyr::rename(city30, c(block="Mblk", autostud_street="fullname"))

#city30$state<-state_abbr
#city30$city<-city_name
city30$address<-paste(city30$hn, city30$fullname, sep=" ")
#names(city30)
#View(city30)

write.csv(city30, paste(dir_path,"\\GIS_edited\\",city_name,"_1930_Addresses.csv",sep=""))
write.csv(city30, "Z:\\Projects\\1940Census\\SanAntonio\\GIS edited\\SanAntonio_1930_Addresses.csv")
write.csv(city30, "Z:/Projects/1940Census/SanAntonio/GIS edited/SanAntonio_1930_Addresses.csv")

