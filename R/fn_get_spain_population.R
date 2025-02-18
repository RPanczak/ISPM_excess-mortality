fn_get_spain_population <- function(data){
  
  pop_spain <-  read_excel(data,sheet=1,range="A8:E212") %>%
    slice(., -(1:2)) %>%
    select(1,5) %>%
    rename(Population=`Both sexes...5`) %>%
    filter(!is.na(Population)) %>%
    mutate(Age=0:(nrow(.)-1)) %>%
    select(Age, Population)
  
  return(pop_spain)
  
}