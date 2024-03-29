#' Rapidly calculate the correlation and the significance of pairs of columns from two data.frames
#'
#' @param table1 A data.frame
#' @param table2 A data.frame
#' @param table1_name Name to give the column giving the name of features in table1. Default is "table1". 
#' @param table2_name Name to give the column giving the name of features in table2. Default is "table2".  
#' @param cor_method A character string indicating which correlation coefficient is to be computed. 
#' One of either "pearson" or "spearman" or their abbreviations. 
#' @param p_adjust_method Method used to adjust p-values. Same as the methods from p.adjust.methods. Default is Benjamini-Hochberg.
#' Setting to "none" will result in no adjusted p-values being calculated.  
#' @param n_covariates Number of covariates if calculating partial correlations. Defaults to 0. 
#' @return A data.frame with the correlation and its significance for all pairs consisting of a variable from table1 and a variable from table2. 
#' @export
#' @examples 
#'
#' # Divide mtcars into two tables
#' table1 <- mtcars[, 1:5]
#' table2 <- mtcars[, 6:11]
#' 
#' # Calculate correlation between table1 and table2
#' cor_results <- methodical::rapidCorTest(table1, table2, cor_method = "spearman", 
#'   table1_name = "feature1", table2_name = "feature2")
#' head(cor_results)
#'
rapidCorTest <- function(table1, table2, cor_method = "pearson", table1_name = "table1", table2_name = "table2", p_adjust_method = "BH", n_covariates = 0){
  
  # Check that inputs have the correct data type
  stopifnot(is(table1, "data.frame") | is(table1, "matrix"), 
    is(table2, "data.frame") | is(table2, "matrix"),
    is(table1_name, "character"), is(table2_name, "character"),
    is(cor_method, "character"), 
    is(p_adjust_method, "character") & p_adjust_method %in% p.adjust.methods)
  
  # Check that cor_method is either "pearson" or "spearman"
  match.arg(cor_method, choices = c("pearson", "spearman"))
    
  # Check that the number of rows in table1 and table2 are equal
  if(nrow(table1) != nrow(table2)){
    stop("Number of rows of table1 and table2 must be equal")
  }
  
  # Calculate the number of complete pairs of observations for each column in df with vec
  n <- apply(table2, 2, function(x)
    colSums((!is.na(table1)) & !is.na(x)))
  
  # Calculate specified correlation values
  cors <- cor(table1, table2, use = "p", method = cor_method)
  
  # Get degrees of freedom
  df <- n - 2 - n_covariates
  
  # Calculate t-statistics from correlations
  t_stat <- cors * sqrt(df)/sqrt((1-cors^2))
  
  # Calculate p-values from t-statistics
  p_val <- as.data.frame(2*(pt(-abs(t_stat), df = df)))
  
  # Convert p-val to long format
  p_val <- tidyr::pivot_longer(
    tibble::rownames_to_column(p_val, table1_name), -!!table1_name, names_to = table2_name, values_to = "p_val")
  
  # Convert cors to long format
  cors <- data.frame(cors)
  cors <- tidyr::pivot_longer(
    tibble::rownames_to_column(cors, table1_name), -!!table1_name, names_to = table2_name, values_to = "cor")
  
  # Add p_val to cors
  cors$p_val <- p_val$p_val
  
  # Calculate q-values from p-values using specified method
  if(p_adjust_method != "none"){
    cors$q_val <- p.adjust(p = cors$p_val, method = p_adjust_method)
  }
  
  # Return a data.frame with correlations, p-values and q-values
  return(data.frame(cors))
  
}
