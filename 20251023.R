# default IRIS data for practice
head(iris, 3)

summary(iris)

str(iris)

# install.packages("Amelia")
library(Amelia)
copy_iris <- iris

# Sepal.Length에 30개의 결측값 생성
copy_iris[sample(1:150, 30), 1] <- NA

# 결측치 시각화
missmap(copy_iris)


# 결측값 대치 방법
complete_iris <- iris
dim(complete_iris)
# Sepal.Length에 30개의 결측값 생성
complete_iris[sample(1:150, 30), 1] <- NA
# 1. 단순대치법
complete_iris <- complete_iris[complete.cases(complete_iris) ,]
# 30개의 결측치 행 제거
dim(complete_iris)
missmap(complete_iris)
