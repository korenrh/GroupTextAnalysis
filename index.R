## RStudio allows you to run each line as you work with Run above.
## See results in bottom right.

## Packages are groups of functions that you can use.
## We are putting the following packages into the Library to use.
library("RDSTK")
library("readr")
library("qdap")
library("syuzhet")
library("ggplot2")
library("dplyr")

??syuzhet
??qdap

## loading in rap, pop, rock, and poetry
drake = read_file("archive/drake.txt")
kanye = read_file("archive/kanye-west.txt")
biggie = read_file("archive/notorious-big.txt")
mj = read_file("archive/michael-jackson.txt")
britney = read_file("archive/britney-spears.txt")
biebs = read_file("archive/bieber.txt")
hendrix = read_file("archive/jimi-hendrix.txt")
nirvana = read_file("archive/nirvana.txt")
blink = read_file("archive/blink-182.txt")
dickinson = read_file("archive/dickinson.txt")
nursery_rhymes = read_file("archive/nursery_rhymes.txt")
seuss = read_file("archive/dr-seuss.txt")

## collect all of our texts into a vector
texts <- c(drake,kanye,biggie,mj,britney,biebs,hendrix,nirvana,blink,dickinson,nursery_rhymes,seuss)

## get sentiment for each of these texts
## collecting them all into a data frame
## generating a barplot for each as well
sentiment_data = data.frame()
artists <- c("Drake","Kanye","B.I.G","MJ","Britney","Biebs","Hendrix","Nirvana","Blink-182","Dickinson","Suess","Nursery Rhymes")
## looping over all 12 artist
for(i in 1:12) {
  ## get sentiment and polarity
  df <- get_nrc_sentiment(texts[i])
  sentiment_data <- rbind(sentiment_data, df)
  polarity = df[1,9:10]
  sentiment = df[1,1:8]
  polarity = data.matrix(polarity, rownames.force = TRUE)
  sentiment = data.matrix(sentiment, rownames.force = TRUE)
  ## generate barplots for each
  barplot(sentiment,
          main = artists[i],
          ylab = "Count",
          names.arg = c("Anger","Anticipation","Disgust","Fear","Joy","Sadness","Surprise","Trust"),
          las=2)
  barplot(polarity,main=artists[i])
}
## view the sentiment counts as a table
View(sentiment_data)


## Next, we need to read our files by line to treat the
## lyric lines as sentences.
## With this, we can do sentiment analysis by line!

drake = readLines("archive/drake.txt")
kanye = readLines("archive/kanye-west.txt")
biggie = readLines("archive/notorious-big.txt")
mj = readLines("archive/michael-jackson.txt")
britney = readLines("archive/britney-spears.txt")
biebs = readLines("archive/bieber.txt")
hendrix = readLines("archive/jimi-hendrix.txt")
nirvana = readLines("archive/nirvana.txt")
blink = readLines("archive/blink-182.txt")
dickinson = readLines("archive/dickinson.txt")
nursery_rhymes = readLines("archive/nursery_rhymes.txt")
seuss = readLines("archive/dr-seuss.txt")

## collect all of our texts back into a vector

## This could be done with a loop like with the sentiment word data
## but R is a bit finicky with vectors within vectors, so we'll do this manually.
## Here we'll get sentiment analysis for each, including mean, min, max, and
## a boxplot!

drake_sen = get_sentiment(drake, method = "syuzhet")
kanye_sen = get_sentiment(kanye, method = "syuzhet")
biggie_sen = get_sentiment(biggie, method = "syuzhet")
boxplot(biggie_sen,kanye_sen,drake_sen,
        main="Hip-Hop Sentiments",
        names=c("Biggie","Kanye","Drake"))

mj_sen = get_sentiment(mj, method = "syuzhet")
britney_sen = get_sentiment(britney, method = "syuzhet")
biebs_sen = get_sentiment(biebs, method = "syuzhet")
boxplot(mj_sen,britney_sen,biebs_sen,
        main="Pop Sentiments",
        names=c("M. Jackson","B. Spears","J. Bieber"))

hendrix_sen = get_sentiment(hendrix, method = "syuzhet")
nirvana_sen = get_sentiment(nirvana, method = "syuzhet")
blink_sen = get_sentiment(blink, method = "syuzhet")
boxplot(hendrix_sen,nirvana_sen,blink_sen,
        main="Alt/Rock Sentiments",
        names=c("Hendrix","Nirvana","Blink-182"))

dick_sen = get_sentiment(dickinson, method = "syuzhet")
nursery_rhymes_sen = get_sentiment(nursery_rhymes, method = "syuzhet")
seuss_sen = get_sentiment(seuss, method = "syuzhet")
boxplot(dick_sen,nursery_rhymes_sen,seuss_sen,
        main="Poetry/Children's Sentiments",
        names=c("Dickinson","Nursery Rhymes","Dr. Seuss"))

## calculate mean, min, max, 25th percentile and 75th percentile
mean <- c(mean(drake_sen),mean(kanye_sen),mean(biggie_sen),
         mean(mj_sen),mean(britney_sen),mean(biebs_sen),
         mean(hendrix_sen),mean(nirvana_sen),mean(blink_sen),
         mean(dick_sen),mean(nursery_rhymes_sen),mean(seuss_sen))
min <- c(min(drake_sen),min(kanye_sen),min(biggie_sen),
         min(mj_sen),min(britney_sen),min(biebs_sen),
         min(hendrix_sen),min(nirvana_sen),min(blink_sen),
         min(dick_sen),min(nursery_rhymes_sen),min(seuss_sen))
max <- c(max(drake_sen),max(kanye_sen),max(biggie_sen),
         max(mj_sen),max(britney_sen),max(biebs_sen),
         max(hendrix_sen),max(nirvana_sen),max(blink_sen),
         max(dick_sen),max(nursery_rhymes_sen),max(seuss_sen))
p25 <- c(quantile(drake_sen,0.25),quantile(kanye_sen,0.25),quantile(biggie_sen,0.25),
         quantile(mj_sen,0.25),quantile(britney_sen,0.25),quantile(biebs_sen,0.25),
         quantile(hendrix_sen,0.25),quantile(nirvana_sen,0.25),quantile(blink_sen,0.25),
         quantile(dick_sen,0.25),quantile(nursery_rhymes_sen,0.25),quantile(seuss_sen,0.25))
p75 <- c(quantile(drake_sen,0.75),quantile(kanye_sen,0.75),quantile(biggie_sen,0.75),
         quantile(mj_sen,0.75),quantile(britney_sen,0.75),quantile(biebs_sen,0.75),
         quantile(hendrix_sen,0.75),quantile(nirvana_sen,0.75),quantile(blink_sen,0.75),
         quantile(dick_sen,0.75),quantile(nursery_rhymes_sen,0.75),quantile(seuss_sen,0.75))

## collect stats into a data frame
stats = data.frame(artists,mean,min,max,p25,p75)
View(stats)






