
purrr_lm <- function(df){
  
  #' @description fit a linear model using species id as explanatory variable and productivity value as response variable
  #' @author Julen Astigarraga
  #' @param df a dataframe with species id and productivity value information
  #' @return a linear model
  
  lm(data = df, prod_value ~ species)
  
}