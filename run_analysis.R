#Set working directory
#setwd("/home/kannappan/r/course3")



#Read train data
Train.core<-read.table("train/X_train.txt")


Train.labels<-read.table("train/y_train.txt",col.names="lab")

Train.subject<-read.table("train/subject_train.txt",,col.names="sub")

Train<-cbind(Train.subject,Train.labels,Train.core)


#Read test data
Test.core<-read.table("test/X_test.txt")

Test.labels<-read.table("test/y_test.txt",col.names="lab")

Test.subject<-read.table("test/subject_test.txt",col.names="sub")

Test<-cbind(Test.subject,Test.labels,Test.core)

All_data<-rbind(Train,Test)


#Read features
features<-read.table("features.txt",stringsAsFactors=FALSE)

#take only mean std
features.me.std<-features[grep("mean\\(\\)|std\\(\\)",features$V2),]

#All data only mean and standard deviation
data.mean.std <- All_data[, c(1, 2, features.me.std$V1+2)]

#Read activity labels
act.labels<-read.table("activity_labels.txt")

#Assign values to labels
data.mean.std$lab <- act.labels[data.mean.std$lab, 2]


#Prepare list of col names
colnames.All_data<-c("subject","labels",features.me.std$V2)

#Clean up colnames
colnames.All_data<-tolower(gsub("[^[:alpha:]]", "", good.colnames))

#Assign appropriate column names to main data set
colnames(data.mean.std)<-colnames.All_data


#Aggregate data based on subject and label
final.data<-aggregate(data.mean.std[,3:ncol(data.mean.std)],by=list(subject=data.mean.std$subject,label=data.mean.std$label),mean)

#Write data to file
write.table(final.data,"final_data.txt",row.names=F,col.names=F,quote=FALSE)




