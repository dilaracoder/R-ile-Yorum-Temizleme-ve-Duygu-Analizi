#Duygu Analizi

nrc<- get_sentiments("nrc")

get_sentiments("nrc") %>%
  count(sentiment)

nrc_duygu <- nrc%>%
  count(sentiment,sort = TRUE)

nrc%>%count(sentiment,sort = TRUE)%>%ggplot(aes(reorder(sentiment,n),n,fiil= sentiment)) + 
  geom_col()+coord_flip()+labs(x="duygu", y="frekans",title = "Yapay zeka spikerleri",subtitle = "NRC sC6zlC<DC<ne gC6re")+theme_minimal()

#sacilim grafigi
polarite<- sentiment(df$word)
stat.desc(polarite$sentiment, basic=T) %>% pander()

tablo<-cbind(df$word, polarite[,c(3,4)])

ggplot(tablo, aes(word_count, sentiment))+
  geom_point(color="blue")+
  geom_hline(yintercept = mean(tablo$sentiment), color="red", size=1)+
  labs(y = "Terimler", x = "Kelimelerin FrekansD1") +
  theme_gray()+
  labs()+
  theme(plot.caption = element_text(hjust = 0, face = "italic"))


d6<-df %>% 
  inner_join(get_sentiments("bing"),by="word")
d6%>% group_by(sentiment) %>% summarise(toplam=sum(freq)) %>% mutate(oran=round(toplam/sum(toplam)*100,2)) %>% arrange(desc(oran)) %>% rename("duygu"="sentiment") %>% data.table(extensions = 'Buttons', 
                                                                                                                                                                                  