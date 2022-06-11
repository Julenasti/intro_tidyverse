read_all_csv <- function(path){
  here(path) %>%
    dir_ls(regexp = "\\.csv$") %>% 
    map(read_delim)
}
