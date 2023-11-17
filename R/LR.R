#'Linear Regression Summary
#'
#'Gets the Linear regression model and some summary result of aimed data
#'
#'@param data input aimed data that need to fit linear regression model
#'
#'@param x the list of names of independent variables
#'
#'@param y name of dependent variable
#'
#'@return the statistics of linear regression
#'
#'@examples
#'library(datasets)
#'data(swiss)
#'data <- swiss
#'x <- c("Fertility", "Agriculture", "Examination", "Education")
#'y <- "Infant.Mortality"
#'LR(data, x, y)
#'
#'@export
#'



LR <- function(data, x, y) {

  # data cleaning
  data <- na.omit(data)

  # divide into y and x list
  y_data <- subset(data, select = y)
  x_data <- subset(data, select = x)

  # beta
  x_matrix <- model.matrix(as.formula(paste("~", paste(colnames(x_data), collapse = "+")))
                           , data = data)
  y_matrix <- as.matrix(y_data)

  beta_hat <- solve(t(x_matrix) %*% x_matrix) %*% t(x_matrix) %*% y_matrix

  # formula
  y_names <- colnames(y_matrix)
  x_names <- colnames(x_matrix)

  formula_LR <- paste(c(y_names, paste(x_names, collapse = " + ")), collapse = " ~ ")

  p <- ncol(x_matrix)

  # residual
  residual <- as.vector(y_matrix - x_matrix %*% beta_hat)
  residual_square <- residual^2
  residual_summary <- data.frame("Min." = min(residual), "1st Qu." = quantile(residual)[[2]], "Median" = quantile(residual)[[3]],
                                 "3Q" = quantile(residual)[[4]], "Max" = quantile(residual)[[5]], check.names = FALSE)

  # F-stat and p_value
  n <- nrow(data)
  SSE <- sum(residual_square)
  SSR <- t(y_matrix) %*% ((x_matrix %*% solve(t(x_matrix) %*% x_matrix) %*% t(x_matrix))
                          - matrix(1/n, n, n)) %*% y_matrix
  F_stat <- (SSR/(p-1)) / (SSE/(n-p))
  df_1 <- p - 1
  df_2 <- n - p
  p_value_F <- pf(F_stat, p-1, n-p, lower.tail = FALSE)

  # R-squared
  Multiple_R_Squared <- 1 - (SSE/(SSR + SSE))
  Adjusted_R_Squared <- 1 - (SSE/(n-p)) / ((SSE + SSR)/(n-1))

  # std_error
  var_betahat <- SSE/(n-p) * solve(t(x_matrix) %*% x_matrix)
  std_error <- sqrt(diag(var_betahat))

  # t_score
  t_score <- beta_hat / std_error
  p_value_t <- 2 * pt(abs(t_score), n-p, lower.tail = FALSE)

  # Coefficients
  list_coefficients <- data.frame("Estimate" = as.vector(beta_hat), "Std. Error" = std_error,
                                  "t value" = as.vector(t_score), "Pr(>|t|)" = as.vector(p_value_t),
                                  row.names = as.vector(colnames(x_matrix)), check.names = FALSE)

  # Confidence Interval
  t <- qt(0.975 , df = n-p)
  CI_95 <- data.frame("2.5 %" = as.vector(beta_hat - t * std_error), "97.5 %" = as.vector(beta_hat + t * std_error),
                      row.names = as.vector(colnames(x_matrix)), check.names = FALSE)

  # output capture
  output <- capture.output({

    # output command
    ## output formula
    cat("formula = ", formula_LR)

    ## output residuals stat
    cat("\n\nResiduals:\n")
    print(residual_summary, row.names = FALSE)

    ## output coefficients
    cat("\nCoefficients:\n" )
    print(list_coefficients)
    cat("---\n\n")

    ## output 95% CI
    cat("95% Confidence Interval: \n")
    print(CI_95)
    cat("---\n\n")

    ## output R-squared
    cat("Multiple R-squared: ", Multiple_R_Squared,", ", "Adjusted R-squared: ", Adjusted_R_Squared, "\n" )

    ## output F stat
    cat("F-statistic: ", F_stat, " on ", df_1, " and ", df_2, " DF,", "p-value: ", p_value_F, "\n")
  })

  cat(paste(c(output), collapse = "\n"))
  cat("\n---\n\n")
  return(list(residuals = residual_summary, coefficients = list_coefficients, CI_95 = CI_95, MRS = Multiple_R_Squared,
              ARS = Adjusted_R_Squared, F_statistic = F_stat, p_value_F = p_value_F))

}