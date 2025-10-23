class('abc')
class(Inf)
class(TRUE)

# result : warning
sqrt(-3)

# root
sqrt(4)

string1 <- 'abc'
# print
string1

# NA
string2 = NA

# NULL
string3 = NULL

is.na(string1)
is.na(string2)
is.null(string3)

# vector - concatenate function
v4 <- c(3, TRUE, FALSE)
v4

v1 <- c(1:6)
v1

# matrix
m1 <- matrix(c(1:6), nrow = 2)
m1

m2 <- matrix(c(1:6), ncol = 2)
m2

m3 <- matrix(c(1:6), byrow = TRUE)
m3
# 1 3 5
# 2 4 6

# array
a1 <- array(c(1:6), dim = c(2, 3, 2))
a1

# list : can insert any type
# start index : 1
L <- list()
L[[1]] <- 5
L[[2]] <- c(1:6)
L[[3]] <- matrix(c(1:6), nrow = 2)
L[[4]] <- array(c(1:6), dim = c(2, 3, 2))
# print
L

# data.frame
# similar vector, can insert different type data
v1 <- c(1, 2, 3)
v2 <- c('a', 'b', 'c')
df1 <- data.frame(v1, v2)
# print
df1

# remove
rm(L)

# show variable list
ls()

# create sequence with 'by' option
seq(1, 10, by = 2)

# repeat(number, count)
rep(1, 5)

print(10)

v1 <- c(1:9)

sum(v1)
# 평균
mean(v1)
# 중앙값
median(v1)
# 표본 분산
var(v1)
# 표준 편차
sd(v1)

max(v1)
min(v1)
range(v1)

# 요약 값
summary(v1)

# colnames & rownames
m1 <- matrix(c(1:6), nrow = 2)
colnames(m1) <- c('c1', 'c2', 'c3')
rownames(m1) <- c('r1', 'r2')
m1
colnames(m1)
rownames(m1)

# 데이터 추출
m1[2, 2]
m1[, 'c2']

# dataframe 접근 : $
df1$v1

# 데이터 결합
rbind(v1, v2)
cbind(v1, v2)

# 반복문
for (i in 1:3)
  print(i)

# 조건문
number <- 5
if (number < 5) {
  print('A')
} else{
  print('B')
}

# 사용자 지정 함수
compareTo5 <- function(number) {
  if (number < 5) {
    print('A')
  } else{
    print('B')
  }
}

compareTo5(10)
