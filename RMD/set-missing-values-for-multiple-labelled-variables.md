stack overflow
================

*URL*: [<http://stackoverflow.com/questions/43529972>](http://stackoverflow.com/questions/43529972)

*Date*: 2017-05-03 15:08:05

### QUESTION

How to I set missing values for multiple labelled vectors in a data frame. I am working with a survey dataset from spss. I am dealing with about 20 different variables, with the same missing values. So would like to find a way to use lapply() to make this work, but I can't.
I actually can do this with base R via as.numeric() and then recode() but I'm intrigued by the possibilities of haven and the labelled class so I'd like to find a way to do this all in Hadley's tidyverse Roughly the variables of interest look like this. I am sorry if this is a basic question, but I find the help documentaiton associated with the haven and labelled packages just very unhelpful.

``` {.r}
library(haven)
library(labelled)
v1<-labelled(c(1,2,2,2,5,6), c(agree=1, disagree=2, dk=5, refused=6))
v2<-labelled(c(1,2,2,2,5,6), c(agree=1, disagree=2, dk=5, refused=6))
v3<-data.frame(v1=v1, v2=v2)
lapply(v3, val_labels)
lapply(v3, function(x) set_na_values(x, c(5,6)))
```

### ANSWER

``` {.r}
print("I SAID FUCK IT WE'LL DO IT LIVE. WE'LL DO IT LIVE!")
```

    ## [1] "I SAID FUCK IT WE'LL DO IT LIVE. WE'LL DO IT LIVE!"
