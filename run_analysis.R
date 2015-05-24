
train_data<-read.table("X_train.txt",header=FALSE)
test_data<-read.table("X_test.txt",header=FALSE)
train_label<-read.table("y_train.txt",header=FALSE)
test_label<-read.table("y_test.txt",header=FALSE)
features_name<-read.table("features.txt",header=FALSE)
labels<-read.table("activity_labels.txt")
labels<-labels[,2]
test_subject<-read.table("subject_test.txt")
train_subject<-read.table("subject_train.txt")
merged_raw_data<-rbind(train_data,test_data)
final_subject<-rbind(train_subject,test_subject)
colnames(final_subject)<-"Subject"
colnames(merged_raw_data)<-features_name[,2]

merged_label<-rbind(train_label,test_label)


colnames(merged_label)<-"Labels"

index<-grep("[Mm]ean|[Ss]td",names(merged_raw_data))
merged_data<-merged_raw_data[,index]
merged_data<-cbind(merged_data,merged_label)
merged_data<-cbind(merged_data,final_subject)
for (i in seq(1:length(labels))){
  merged_data$Labels<-gsub(i,as.character(labels[i]),merged_data$Labels)
}
merged_label<-as.data.frame(merged_label)

merged_data_2<-NULL
final_label<-NULL
final_subject<-NULL
for (i in seq(1:30)){
    for (j in seq(1:length(labels))){
      final_subject<-rbind(final_subject,i)
      final_label<-rbind(final_label,labels[j])
      temp<-merged_data[merged_data$Subject==i,]
      temp<-temp[temp$Labels==labels[j],]
      merged_data_2<-rbind(merged_data_2,colMeans(temp[,1:86]))
    }
  

}
colnames(final_subject)<-"Subject"
colnames(final_label)<-"Labels"
merged_data_2<-as.data.frame(merged_data_2)
write.table(merged_data_2,"output.txt",row.names=FALSE)

