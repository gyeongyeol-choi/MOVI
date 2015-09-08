# rscript2.r(Time Plot+Simple Bar Plot)
# Output Option(-o)
fun_output <- function(){
	flag = FALSE
	args <- commandArgs(trailingOnly = TRUE)
	if(length(args) != 0){
        	for(i in 1:length(args)){
                	if(args[i] == '-o'){
                        	flag = TRUE
				dir = paste("save", args[i+1], sep="/")
                        	if(args[i+2] == 'pdf')
                                	pdf(dir) # width = 9, height = 5)
                        	if(args[i+2] == 'wmf')
                                	win.metafile(dir)
                        	if(args[i+2] == 'png')
                                	png(dir)
                        	if(args[i+2] == 'jpg')
                                	jpeg(dir)
                        	if(args[i+2] == 'bmp')
                                	bmp(dir)
                        	if(args[i+2] == 'ps')
                                	postscript(dir)
                	}
        	}
	}		
	if(flag == FALSE){
        	pdf('save/T-Rplots.pdf')
	}
}
fun_output2 <- function(){
	jpeg('save/T-Rplot%03d.jpg')
}
#most <- read.table("result3.po", sep='\t', fill = TRUE, stringsAsFactors=FALSE)
#colnames(most) <-c("time", "action", "RW", "sec_num", "sec_size", "p_io", "pname", "block", "file")
#write.table(most, "sample.txt")
#barplot(table(most$action))
#barplot(table(most$RW))
#barplot(table(most$sec_size))

# Function for Sector Number Graph
fun_num <- function(most,...){
	plot(sec_num~time, data=most)
	xrange<-c(min(most$time),max(most$time))
	#xrange<-c(0, 7)
	yrange<-c(min(most$sec_num), max(most$sec_num))
	#yrange<-c(0, 2.5e+7)
	plot(sec_num~time, data=most[most$block == "D",], col="blue", xlim=xrange, ylim=yrange)
	par(new = T)
	plot(sec_num~time, data=most[most$block == "J",], col="red", xlim=xrange, ylim=yrange)
	par(new = T)
	plot(sec_num~time, data=most[most$block == "M",], col="black", xlim=xrange, ylim=yrange)
	legend("right", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("blue", "red", "black"))
}
# Function for Sector Size Graph
fun_size <- function(most,...){
	plot(sec_size~time, data=most)
	xrange<-c(min(most$time),max(most$time))
	#xrange<-c(0, 7)
	yrange<-c(min(most$sec_size), max(most$sec_size))
	#yrange<-c(0, 150)
	plot(sec_size~time, data=most[most$block == "D",], col="blue", xlim=xrange, ylim=yrange)
	par(new = T)
	plot(sec_size~time, data=most[most$block == "J",], col="red", xlim=xrange, ylim=yrange)
	par(new = T)
	plot(sec_size~time, data=most[most$block == "M",], col="black", xlim=xrange, ylim=yrange)
	legend("topright", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("blue", "red", "black"))
}
# Y-axis Option(-y)
fun_y <- function(){
	args <- commandArgs(trailingOnly = TRUE)
	flag = FALSE
	if(length(args) != 0){
        	for(i in 1:length(args)){
                	if(args[i] == '-y'){
				flag = TRUE
                        	if(args[i+1] == 's'){
                        	        #plot(sec_size~time, data=most)
					fun_size(most)
				}
                        	if(args[i+1] == 'n'){
                        	        #plot(sec_num~time, data=most)
					fun_num(most)
				}
                        	if(args[i+1] == 'all'){
                        	        #plot(sec_size~time, data=most)
					fun_size(most)
					#plot(sec_num~time, data=most)
					fun_size(most)
				}
                	}	
        	}
	}
	if(flag == FALSE){
		fun_size(most)
		fun_num(most)
		yrange_RW<-c(0,max(table(most$RW))*1.25)
		barplot(table(most$RW), xlab = "rwbs type", ylab = "I/O Count", ylim = yrange_RW)
		yrange_SS<-c(0,max(table(most$sec_size))*1.25)
		barplot(table(most$sec_size), xlab = "sec_size", ylab = "I/O Count", ylim = yrange_SS)
		#plot(sec_num~time, data=most)
        	#plot(sec_size~time, data=most)
	}
}
#plot(sec_num~time, data=most)
#plot(sec_size~time, data=most)
#fun_num <- function(most,...){
#xrange<-c(0, 7)
#yrange<-c(0, 2.5e+7)
#plot(sec_num~time, data=most[most$block == "D",], col="blue", xlim=xrange, ylim=yrange)
#par(new = T)
#plot(sec_num~time, data=most[most$block == "J",], col="red", xlim=xrange, ylim=yrange)
#par(new = T)
#plot(sec_num~time, data=most[most$block == "M",], col="black", xlim=xrange, ylim=yrange)
#legend("right", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("blue", "red", "black"))
#}
#library(ggplot2)
#ggplot(most, aes(x=time, y=sec_num)) + geom_point(aes(colour=block))
#ggplot(most, aes(x=action)) + geom_bar(aes(fill=block))
sub_main <- function(){
	fun_output()
	fun_y()
	fun_output2()
	fun_y()
	garbage <- dev.off()
}
# main
most <- read.table("result3.po", sep='\t', fill = TRUE, stringsAsFactors=FALSE)
colnames(most) <-c("time", "action", "RW", "sec_num", "sec_size", "p_io", "pname", "block", "file")
sub_main()
