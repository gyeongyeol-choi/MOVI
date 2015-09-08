# rscript.r(Cumulative Bar Plot-Block type)
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
        	pdf('save/B-Rplots.pdf')
	}
}
fun_output2 <- function(){
	jpeg('save/B-Rplot%03d.jpg')
}

fun_rwbs1 <- function(){ # block to rwbs, I/O Count
	most <- read.table("block_rwbs1.dat")
	most_matrix <- data.matrix(most)
	trans <- t(most_matrix)
	trans_select <- trans[, !colSums(trans)==0]
	yrange<-c(0,max(colSums(trans_select))*1.25)
	barplot(trans_select,  xlab = "rwbs type", ylab = "I/O Count", col=c("lightblue","lightgreen", "lightyellow"), ylim = yrange)
	legend("topleft", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("lightblue","lightgreen", "lightyellow"))
}
fun_rwbs2 <- function(){ # block to rwbs, I/O Count(%)
        most <- read.table("block_rwbs2.dat")
        most_matrix <- data.matrix(most)
        trans <- t(most_matrix)
        trans_select <- trans[, !colSums(trans)==0]
        yrange<-c(0,max(colSums(trans_select))*1.25)
        barplot(trans_select,  xlab = "rwbs type", ylab = "I/O Count(%)", col=c("lightblue","lightgreen", "lightyellow"), ylim = yrange)
        legend("topleft", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("lightblue","lightgreen", "lightyellow"))
}
fun_rwbs3 <- function(){ # block to rwbs, I/O Size(1024kb)
        most <- read.table("block_rwbs3.dat")
        most_matrix <- data.matrix(most)
        trans <- t(most_matrix)
        trans_select <- trans[, !colSums(trans)==0]
        yrange <- c(0,max(colSums(trans_select))*1.25)
        barplot(trans_select,  xlab = "rwbs type", ylab = "I/O Size(1024KB)", col=c("lightblue","lightgreen", "lightyellow"), ylim = yrange)
        legend("topleft", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("lightblue","lightgreen", "lightyellow"))
}
fun_rwbs4 <- function(){ # block to rwbs, I/O Size(%)
        most <- read.table("block_rwbs4.dat")
        most_matrix <- data.matrix(most)
        trans <- t(most_matrix)
        trans_select <- trans[, !colSums(trans)==0]
        yrange<-c(0,max(colSums(trans_select))*1.25)
        barplot(trans_select,  xlab = "rwbs type", ylab = "I/O Size(%)", col=c("lightblue","lightgreen", "lightyellow"), ylim = yrange)
        legend("topleft", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("lightblue","lightgreen", "lightyellow"))
}

fun_action <- function(){
        most <- read.table("block_action.dat")
        most_matrix <- data.matrix(most)
        trans <- t(most_matrix)
        trans_select <- trans[, !colSums(trans)==0]
        barplot(trans_select,  xlab = "action", ylab = "I/O Count", col=c("lightblue","lightgreen", "lightyellow"))
        legend("topleft", legend=c("Data", "Journal", "Meta"), pch=21, pt.bg=c("lightblue","lightgreen", "lightyellow"))
}

# main
main <- function(){
	fun_output()
	fun_rwbs1()
	fun_rwbs2()
	fun_rwbs3()
	fun_rwbs4()
	#fun_action()
	fun_output2()
	fun_rwbs1()
	fun_rwbs2()
	fun_rwbs3()
	fun_rwbs4()
	garbage <- dev.off()
	#fun_action()
}
main()
