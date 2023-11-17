test_that("multiplication works", {
  library(datasets)
  data(swiss)
  data <- swiss
  x <- c("Fertility", "Agriculture", "Examination", "Education")
  y <- "Infant.Mortality"
  LR_1 <- LR(data, x, y)
  model = lm(Infant.Mortality ~ Fertility + Agriculture + Examination + Education, data = swiss)
  summary(model)
  model_CI <- confint(model)
  pf <- pf(summary(model)$fstatistic[[1]], summary(model)$fstatistic[[2]], summary(model)$fstatistic[[3]], lower.tail = FALSE)

  expect_equal(as.matrix(LR_1[[2]]), summary(model)$coefficients)
  expect_equal(as.matrix(LR_1[[3]]), model_CI)
  expect_equal(LR_1[[4]][1], summary(model)$r.squared)
  expect_equal(LR_1[[5]][1], summary(model)$adj.r.squared)
  expect_equal(LR_1[[6]][1], summary(model)$fstatistic[[1]])
  expect_equal(LR_1[[7]][1], pf)
})
