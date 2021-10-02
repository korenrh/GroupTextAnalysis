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

## If you don't know what a package is, you can ask. Use ctrl-return or press Run above.
## I have placed these queries in the code, but better practice is to type it directly
## in the console below.

??syuzhet
??qdap

## make VERY sure that the following packages have loaded-- base, datasets, dplyr, ggplot2, graphics, grDevices, methods, plyr, qdap, qdapDictionaries, qdapRegex, qdapTools, RColorBrewer, RCurl, RDSTK, readr, rjson, stats, syuzhet, twitteR, utils

gandhi_speech = read_file("assets/gandhi_speech2.txt")
View(gandhi_speech)

## loading President Obama's 2009 speech
obama_speech = read_file("assets/obama_2009.txt")
View(obama_speech)

## polarity and sentiment
g_scores = get_nrc_sentiment(gandhi_speech)
o_scores = get_nrc_sentiment(obama_speech)
class(o_scores)
class(g_scores)

g_polarity = g_scores[1,9:10]
g_sentiment = g_scores[1,1:8]
o_polarity = o_scores[1,9:10]
o_sentiment = o_scores[1,1:8]

## visualize polarity
class(g_polarity)
class(o_polarity)
g_polarity = data.matrix(g_polarity, rownames.force = TRUE)
o_polarity = data.matrix(o_polarity, rownames.force = TRUE)
barplot(g_polarity)
barplot(o_polarity)

## visualize sentiment
## Given that Obama was taking office on the heels of the recession
## I would expect more positive sentiment, as his campaign
## offered hope during a very difficult time in America
class(g_sentiment)
g_sentiment = data.matrix(g_sentiment, rownames.force = TRUE)
barplot(g_sentiment)
o_sentiment = data.matrix(o_sentiment,rownames.force = TRUE)
barplot(o_sentiment)

## break it down by sentence
g_speech_sen = get_sentences(gandhi_speech)

o_speech_sen = get_sentences(obama_speech)

sentiment_vector = get_sentiment(g_speech_sen, method = "syuzhet")
sentiment_vector_o = get_sentiment(o_speech_sen, method = "syuzhet")

## A vector is a basic data structure in R.
## It is a sequence of elements that share the same data type. 
## A vector supports logical, integer, double, character, complex, or raw data type.
## They have these in C++ too!

sentiment_vector
summary(sentiment_vector)
boxplot(sentiment_vector)

## let's see Obama's sentiments
sentiment_vector_o
summary(sentiment_vector_o)
boxplot(sentiment_vector_o)

#Result: generally pretty positive!

## what was the most positive sentence in the paragraph?
max(sentiment_vector)
sentence_sentiment = data.frame(g_speech_sen, sentiment_vector)
View(sentence_sentiment)
which.max(sentence_sentiment$sentiment_vector)

## we now have an index - what can we do with this?
most_positive = sentence_sentiment[which.max(sentence_sentiment$sentiment_vector),]
## don't forget the comma!

## how about we try most negative as well...
## let's see what Obama's most 'negative' sentence
min(sentiment_vector_o)
sentence_sentiment_o = data.frame(o_speech_sen, sentiment_vector_o)
View(sentence_sentiment_o)
most_negative = sentence_sentiment_o[which.min(sentence_sentiment_o$sentiment_vector_o),]
## let's print the most negative
print(most_negative)

## Wordclouds
## look over to the right and see that these packages are checked
## if one is absent then go to the console below and type install.packages("MISSINGPACKAGE")
library("devtools")
library("RColorBrewer")
library("tm")
library("SnowballC")
library("wordcloud")


wordcloud(gandhi_speech,colors=c("blue","orange"))
## limiting to 50 words that must have been used twice
## let's make a word cloud for Obama!
wordcloud(obama_speech,colors=brewer.pal(8,"Dark2"),max.words=50,min.freq = 2,
          random.order=FALSE,rot.per = 0.35)

