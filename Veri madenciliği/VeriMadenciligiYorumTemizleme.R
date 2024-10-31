library(tuber)
library(tm)
library(wordcloud2)
library(stringr)
library(dplyr)
library(tidytext)
library(readr)

#google oauth api alip yorum cekmek icin izin istedik
myclientid <- "747857616375-g03qhr814761jk9uihhes83g60cvco0d.apps.googleusercontent.com"
clientsecret <- "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"
yt_oauth(myclientid,clientsecret,token = "")


#videolaran yorumlari cekelim
comment <- get_all_comments("MHPI1uH9llU")
comment2 <- get_all_comments("n36C-jUJoi8")
comment3 <- get_all_comments("5iZuffHPDAw")
comment4 <- get_all_comments("bmqd9nYH5Fw")
comment5 <- get_all_comments("YOpQpunuRfw")
comment6 <- get_all_comments("HJcdVjkqiW8")
comment7 <- get_all_comments("0q3v3nTlDaY")



#7 tane videodan olan yorumlari tek bir listede birleEstirelim
allcomments <- list(comment$textOriginal,comment2$textOriginal,comment3$textOriginal,comment4$textOriginal,comment5$textOriginal,comment6$textOriginal,comment7$textOriginal)
print(allcomments)


#veri temizleme islemi
rmvword <- c(stopwords("en") , stopwords("SMART"))
rmvword

allcomments.text <- sapply(allcomments,function(comments) comments)
mycorpus <- Corpus(VectorSource(allcomments.text))

clean_corp <- tm_map(mycorpus,PlainTextDocument) #butun yorumlari tek bir metine donusturduk
clean_corp <- tm_map(clean_corp,content_transformer(removeurl)) #url leri kaldirdik
clean_corp <- tm_map(clean_corp,content_transformer(tolower))  #buyuk harfleri kucuk harfe donusturme
clean_corp <- tm_map(clean_corp,removeWords,rmvword)  #durak kelimeleri temizledik
clean_corp <- tm_map(clean_corp,content_transformer(removePunctuation))
clean_corp <- tm_map(clean_corp,stripWhitespace)
clean_corp <- tm_map(clean_corp,removeNumbers)
clean_corp <- tm_map(clean_corp, gsub, pattern = "b