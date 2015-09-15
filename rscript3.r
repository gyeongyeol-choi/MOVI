# rscript3.r(Cumulative Bar Plot-File type)
# Output Option('-o')
fun_output <- function(){
	flag = FALSE
	args <- commandArgs(trailingOnly = TRUE)

	# Graph Size Option('-s')
	x_length = 7
	y_length = 7
	if(length(args) != 0){
		for(i in 1:length(args)){
			if(args[i] == '-s'){
				x_length = as.double(args[i+1])
				y_length = as.double(args[i+2])
			}
		}
	}		

	if(length(args) != 0){
        	for(i in 1:length(args)){
                	if(args[i] == '-o'){
                        	flag = TRUE
				dir = paste("save", args[i+1], sep="/")
                        	if(args[i+2] == 'pdf')
                                	pdf(dir, width = x_length, height = y_length) # default width = 7, height = 7)
                        	#if(args[i+2] == 'wmf')
                                #	win.metafile(dir, width = x_length, height = y_length)
				# res(resolution-Pixel per Inch) required for converting pixel to inch.
                        	if(args[i+2] == 'png')
                                	png(dir, width = x_length, height = y_length, units = "in", res = 200)
                        	if(args[i+2] == 'jpg')
                                	jpeg(dir, width = x_length, height = y_length, units = "in", res = 200)
                        	if(args[i+2] == 'bmp')
                                	bmp(dir, width = x_length, height = y_length, units = "in", res = 200)
                        	if(args[i+2] == 'ps')
                                	postscript(dir, width = x_length, height = y_length)
                	}
        	}
	}		
	if(flag == FALSE){
        	pdf('save/F-Rplots.pdf', width = x_length, height = y_length)
	}
}
fun_output2 <- function(){
        # Graph Size Option('-s')
	args <- commandArgs(trailingOnly = TRUE)
        x_length = 7
        y_length = 7
        if(length(args) != 0){
                for(i in 1:length(args)){
                        if(args[i] == '-s'){
                                x_length = as.double(args[i+1])
                                y_length = as.double(args[i+2])
                        }
		}
        }
	jpeg('save/F-Rplot%03d.jpg', width = x_length, height = y_length, units="in", res=200)
}
fun_rwbs1 <- function(){ # File to rwbs, I/O Count
	most <- read.table("file_rwbs1.dat")
	most_matrix <- data.matrix(most)
	trans <- t(most_matrix)
	trans_select <- trans[, !colSums(trans)==0]
	trans_select2 <- trans_select[!rowSums(trans_select)==0,]
	colors = c("yellow", "green", "violet", "orange", "blue", "pink", "cyan", "gray", "navy", "lightblue", "lightyellow", "lightgreen", "ivory", "purple", "red", "brown")
	yrange<-c(0,max(colSums(trans_select2))*1.25)
	barplot(trans_select2,  xlab = "rwbs type", ylab = "I/O Count", col=colors, ylim = yrange)
	legend("topleft", legend=rownames(trans_select2), pch=21, cex=0.9, pt.bg = colors)
}
fun_rwbs2 <- function(){# File to rwbs, I/O Count(%)
        most <- read.table("file_rwbs2.dat")
        most_matrix <- data.matrix(most)
        trans <- t(most_matrix)
        trans_select <- trans[, !colSums(trans)==0]
        trans_select2 <- trans_select[!rowSums(trans_select)==0,]
        colors = c("yellow", "green", "violet", "orange", "blue", "pink", "cyan", "gray", "navy", "lightblue", "lightyellow", "lightgreen", "ivory", "purple", "red", "brown")
        yrange<-c(0,max(colSums(trans_select2))*1.25)
        barplot(trans_select2,  xlab = "rwbs type", ylab = "I/O Count(%)", col=colors, ylim = yrange)
        legend("topleft", legend=rownames(trans_select2), pch=21, cex=0.9, pt.bg = colors)
}
fun_rwbs3 <- function(){ # File to rwbs, I/O Size(1024KB)
        most <- read.table("file_rwbs3.dat")
        most_matrix <- data.matrix(most)
        trans <- t(most_matrix)
        trans_select <- trans[, !colSums(trans)==0]
        trans_select2 <- trans_select[!rowSums(trans_select)==0,]
        colors = c("yellow", "green", "violet", "orange", "blue", "pink", "cyan", "gray", "navy", "lightblue", "lightyellow", "lightgreen", "ivory", "purple", "red", "brown")
        yrange<-c(0,max(colSums(trans_select2))*1.25)
        barplot(trans_select2,  xlab = "rwbs type", ylab = "I/O Size(1024KB)", col=colors, ylim = yrange)
        legend("topleft", legend=rownames(trans_select2), pch=21, cex=0.9, pt.bg = colors)
}
fun_rwbs4 <- function(){# File to rwbs, I/O Size(%)
        most <- read.table("file_rwbs4.dat")
        most_matrix <- data.matrix(most)
        trans <- t(most_matrix)
        trans_select <- trans[, !colSums(trans)==0]
        trans_select2 <- trans_select[!rowSums(trans_select)==0,]
        colors = c("yellow", "green", "violet", "orange", "blue", "pink", "cyan", "gray", "navy", "lightblue", "lightyellow", "lightgreen", "ivory", "purple", "red", "brown")
        yrange<-c(0,max(colSums(trans_select2))*1.25)
        barplot(trans_select2,  xlab = "rwbs type", ylab = "I/O Size(%)", col=colors, ylim = yrange)
        legend("topleft", legend=rownames(trans_select2), pch=21, cex=0.9, pt.bg = colors)
}
# Y-axis Option(-y)
fun_y <- function(){
        args <- commandArgs(trailingOnly = TRUE)
        flag = FALSE
        if(length(args) != 0){
                for(i in 1:length(args)){
                        if(args[i] == '-y'){
                                flag = TRUE
                                if(args[i+1] == 'c'){ # I/O Count
                                        fun_rwbs1()
                                        fun_rwbs2()
                                }
                                if(args[i+1] == 's'){ # I/O Size
                                        fun_rwbs3()
                                        fun_rwbs4()
                                }
                                if(args[i+1] == 'all'){
                                        fun_rwbs1()
                                        fun_rwbs2()
                                        fun_rwbs3()
                                        fun_rwbs4()
                                }
                        }
                }
        }
        if(flag == FALSE){ # all is default
                fun_rwbs1()
                fun_rwbs2()
                fun_rwbs3()
                fun_rwbs4()
        }
}

# main
main <- function(){
	fun_output()
	fun_y()
	fun_output2()
	fun_y()
	garbage <- dev.off()
}
main()
