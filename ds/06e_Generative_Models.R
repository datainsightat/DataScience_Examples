library(caret)
library(dslabs)
library(tidyverse)

data("heights")

y <- heights$height

set.seed(2)

test_index <- createDataPartition(y, times = 1, p=0.5, list=FALSE)

train_set <- heights %>% slice(-test_index)
test_set <- heights %>% slice(test_index)

params <- train_set %>% group_by(sex) %>% summarize(avg = mean(height), sd = sd(height))

pi <- train_set %>% summarize(pi=mean(sex=='Female')) %>% .$pi

x <- test_set$height

f0 <- dnorm(x, params$avg[2], params$sd[2])
f1 <- dnorm(x, params$avg[1], params$sd[1])

p_hat_bayes <- f1*pi / (f1*pi + f0*(1-pi))

y_hat_bayes <- ifelse(p_hat_bayes > 0.5, 'Female','Male')

sensitivity(data = factor(y_hat_bayes),reference = factor(test_set$sex))
specificity(data = factor(y_hat_bayes),reference = factor(test_set$sex))

p_hat_bayes_unbiased <- f1*0.5 / (f1*0.5 + f0*(1-0.5))
y_hat_bayes_unbiased <- ifelse(p_hat_bayes_unbiased > 0.5, 'Female','Male')

sensitivity(data = factor(y_hat_bayes_unbiased),reference = factor(test_set$sex))
specificity(data = factor(y_hat_bayes_unbiased),reference = factor(test_set$sex))

qplot(x, p_hat_bayes_unbiased, geom = "line") + 
  geom_hline(yintercept = 0.5, lty = 2) + 
  geom_vline(xintercept = 67, lty = 2)

data("mnist_27")

params <- mnist_27$train %>% group_by(y) %>% summarise(avg_1 = mean(x_1),avg_2 = mean(x_2),sd_1 = sd(x_1), sd_2 = sd(x_2), r = cor(x_1,x_2))
params

params <- params %>% mutate(sd_1 = mean(sd_1), sd_2 = mean(sd_2), r=mean(r))

mnist_27$train %>% mutate(y = factor(y)) %>% 
  ggplot(aes(x_1, x_2, fill = y, color=y)) + 
  geom_point(show.legend = FALSE) + 
  stat_ellipse(type="norm", lwd = 1.5)


library(caret)

train_qda <- train(y ~ ., method='qda',data = mnist_27$train)

y_hat <- predict(train_qda,mnist_27$test)
confusionMatrix(data = y_hat, reference = mnist_27$test$y)$overall['Accuracy']

mnist_27$train %>% mutate(y = factor(y)) %>% 
  ggplot(aes(x_1, x_2, fill = y, color=y)) + 
  geom_point(show.legend = FALSE) + 
  stat_ellipse(type="norm") +
  facet_wrap(~y)


#Parameters: K x (2p + p x (p-1)/2)

train_lda <- train(y ~ ., method='lda', data = mnist_27$test)

y_hat <- predict(train_lda, mnist_27$test)

confusionMatrix(data = y_hat, reference = mnist_27$test$y)$overall['Accuracy']

if(!exists("mnist")) mnist <- read_mnist()

set.seed(3456)

index_127 <- sample(which(mnist$train$labels %in% c(1,2,7)), 2000)
y <- mnist$train$labels[index_127] 
x <- mnist$train$images[index_127,]
index_train <- createDataPartition(y, p=0.8, list = FALSE)

## get the quandrants
#temporary object to help figure out the quandrants
row_column <- expand.grid(row=1:28, col=1:28) 
upper_left_ind <- which(row_column$col <= 14 & row_column$row <= 14)
lower_right_ind <- which(row_column$col > 14 & row_column$row > 14)

#binarize the values. Above 200 is ink, below is no ink
x <- x > 200 

#cbind proportion of pixels in upper right quandrant and
##proportion of pixes in lower rigth quandrant
x <- cbind(rowSums(x[ ,upper_left_ind])/rowSums(x), 
           rowSums(x[ ,lower_right_ind])/rowSums(x)) 

train_set <- data.frame(y = factor(y[index_train]),
                        x_1 = x[index_train,1],
                        x_2 = x[index_train,2])
test_set <- data.frame(y = factor(y[-index_train]),
                       x_1 = x[-index_train,1],
                       x_2 = x[-index_train,2])

train_set %>% 
  ggplot(aes(x_1, x_2, color=y)) + 
  geom_point()


train_qda <- train(y~ ., method = 'qda', data= train_set)

predict(train_qda, test_set, type='prob') %>% head()

predict(train_qda, test_set)

confusionMatrix(predict(train_qda, test_set), test_set$y)


GS <- 150
new_x <- expand.grid(x_1 = seq(min(train_set$x_1), max(train_set$x_1), len=GS),
                     x_2 = seq(min(train_set$x_2), max(train_set$x_2), len=GS))
new_x %>% mutate(y_hat = predict(train_qda, new_x)) %>%
  ggplot(aes(x_1, x_2, color = y_hat, z = as.numeric(y_hat))) +
  geom_point(size = 0.5, pch = 16) + 
  stat_contour(breaks=c(1.5, 2.5),color="black") + 
  guides(colour = guide_legend(override.aes = list(size=2)))


train_lda <- train(y ~ ., method='lda', data=train_set)

confusionMatrix(predict(train_lda, test_set), test_set$y)$overall['Accuracy']


train_knn <- train(y ~ .,
                   method = "knn",
                   tuneGrid = data.frame(k = seq(15, 51, 2)),
                   data = train_set)

confusionMatrix(predict(train_knn, test_set), test_set$y)$overal["Accuracy"]


new_x %>% mutate(y_hat = predict(train_knn, new_x)) %>%
  ggplot(aes(x_1, x_2, color = y_hat, z = as.numeric(y_hat))) +
  geom_point(size = 0.5, pch = 16) + 
  stat_contour(breaks=c(1.5, 2.5),color="black") + 
  guides(colour = guide_legend(override.aes = list(size=2)))


train_set %>% mutate(y = factor(y)) %>% 
  ggplot(aes(x_1, x_2, fill = y, color=y)) + 
  geom_point(show.legend = FALSE) + 
  stat_ellipse(type="norm")