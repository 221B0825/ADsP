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

# --------------------------------------------------

# 결측값 대치 방법
complete_iris <- iris
dim(complete_iris)
# Sepal.Length에 30개의 결측값 생성
complete_iris[sample(1:150, 30), 1] <- NA
# 1. 단순 대치법
complete_iris <- complete_iris[complete.cases(complete_iris) , ]
# 30개의 결측치 행 제거
dim(complete_iris)
missmap(complete_iris)

# 2. 평균 대치법
mean_iris <- iris
mean_iris[sample(1:150, 30), 1] <- NA
# 결측값 제외 평균값
meanValue <- mean (mean_iris$Sepal.Length, na.rm = T)
# 비교용 dataframe 정의
before_mean_iris <- mean_iris
# 결측값에 평균 대치
mean_iris$Sepal.Length[is.na(mean_iris$Sepal.Length)] <- meanValue

# --------------------------------------------------
# 평균 대치 후 Sepal.Length 분포 시각화
hist(
  before_mean_iris$Sepal.Length,
  col = rgb(1, 0, 0, 0.5),
  main = "평균 대치 전/후 비교",
  xlab = "Sepal.Length"
)
hist(mean_iris$Sepal.Length,
     col = rgb(0, 0, 1, 0.5),
     add = TRUE)
legend("topright",
       legend = c("원본", "평균 대치 후"),
       fill = c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5)))
# --------------------------------------------------
boxplot(
  before_mean_iris$Sepal.Length,
  mean_iris$Sepal.Length,
  names = c("원본", "평균 대치 후"),
  col = c("tomato", "skyblue"),
  main = "평균 대치 전후 Sepal.Length 비교"
)
# --------------------------------------------------
# 3. 단순 확률 대치법
knn_iris <- iris
knn_iris[ sample(1:150, 30), 1] <- NA
before_knn_iris <- knn_iris
#install.packages("VIM")
library(VIM)
#knn_iris <- knnImputation(knn_iris, k = 10)
knn_iris <- kNN(knn_iris, variable = "Sepal.Length", k = 10)


# 평균 대치 후 Sepal.Length 분포 시각화
hist(
  before_knn_iris$Sepal.Length,
  col = rgb(1, 0, 0, 0.5),
  main = "평균 대치 전/후 비교",
  xlab = "Sepal.Length"
)
hist(knn_iris$Sepal.Length,
     col = rgb(0, 0, 1, 0.5),
     add = TRUE)
legend("topright",
       legend = c("원본", "평균 대치 후"),
       fill = c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5)))

# --------------------------------------------------
# NA 포함 전/후 Sepal.Length
knn_before <- before_knn_iris$Sepal.Length
knn_after  <- knn_iris$Sepal.Length

# 점으로 분포 보기
plot(jitter(rep(1, length(knn_before))), knn_before,
     col = rgb(1,0,0,0.5), pch=16,
     xlim=c(0.8, 2.2), xaxt="n",
     xlab="", ylab="Sepal.Length", main="KNN 대치 전/후 분포")
points(jitter(rep(2, length(knn_after))), knn_after,
       col = rgb(0,0,1,0.5), pch=16)

axis(1, at=c(1,2), labels=c("KNN 대치 전", "KNN 대치 후"))

# --------------------------------------------------
# 4. 다중 대치법
multi_iris <- iris
multi_iris[sample(1:150, 30), 1] <- NA
library(Amelia)
# 결측값 대치 - 3번의 대치(m 값)
# cs = cross-sectional로 같은 종(Species)끼리 묶어서 결측값을 대치
imp_iris <- amelia(multi_iris, m = 3, cs = "Species")
multi_iris$Sepal.Length <- imp_iris$imputations[[3]]$Sepal.Length

hist(
  multi_iris$Sepal.Length,
  main = "다중 대치 후 Sepal.Length 분포",
  xlab = "Sepal.Length",
  col = "skyblue",
  border = "white"
)
# --------------------------------------------------

# 이상값 판단
esd_iris <- iris$Sepal.Length
# 평균과 표준편차
mu <- mean(esd_iris)
sigma <- sd(esd_iris)

# 히스토그램 (확률 밀도 비율로)
hist(esd_iris, breaks=10, col="lightgray", border="white",
     main="Sepal.Length 히스토그램과 정규분포",
     xlab="Sepal.Length", freq=FALSE)

# 정규분포 곡선
curve(dnorm(x, mean=mu, sd=sigma), from=min(esd_iris), to=max(esd_iris),
      col="red", lwd=2, add=TRUE)

# 평균 선
abline(v=mu, col="blue", lwd=2)

# ±1σ, ±2σ, ±3σ 선 추가
for (k in 1:3) {
  abline(v = mu + k*sigma, col="darkgreen", lty=2)
  abline(v = mu - k*sigma, col="darkgreen", lty=2)
}
# 범례
legend("topright",
       legend=c("평균", "±1σ, ±2σ, ±3σ", "정규분포"),
       col=c("blue", "darkgreen", "red"), lty=c(1,2,1), lwd=c(2,1,2))

# 사분위수
data <- c(3, 10, 13, 16, 11, 20, 17, 25, 43)
boxplot(data, horizontal = T)
