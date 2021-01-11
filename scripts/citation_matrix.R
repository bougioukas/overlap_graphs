# load the packages ----------------------------------------------------

library(formattable) # Create 'Formattable' Data Structures
library(htmltools) # Tools for HTML
library(webshot) # Take Screenshots of Web Pages


library(here) # A Simpler Way to Find Your Files
library(tidyverse) # Easily Install and Load the 'Tidyverse'

  



# read the data --------------------------------------------------------

library(readr) # Read Rectangular Text Data
citation_table <- read_delim(here("data", "citation_table_miyazaki.csv"),
                             ";", escape_double = FALSE, trim_ws = TRUE)






# create the table -----------------------------------------------------

tb <- formattable(citation_table, list(
 "No. of times included" = color_bar("lightgreen"),
  Chasan2014 = formatter("span",
                                       style = x ~ style(color = ifelse(x, "green", "red")),
                                       x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No"))),
  Gilinsky2015 = formatter("span",
                                   style = x ~ style(color = ifelse(x, "green", "red")),
                                   x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No"))),
  
  Guo2016 = formatter("span",
                              style = x ~ style(color = ifelse(x, "green", "red")),
                              x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No"))),
  
  Middleton2014 = formatter("span",
                                    style = x ~ style(color = ifelse(x, "green", "red")),
                                    x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No"))),
  Morton2014 = formatter("span",
                                 style = x ~ style(color = ifelse(x, "green", "red")),
                                 x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No"))),
  Peacock2014 = formatter("span",
                                  style = x ~ style(color = ifelse(x, "green", "red")),
                                  x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No")))
))


tb




# export the table --------------------------------------------------------

export_formattable <- function(f, file, width = "100%", height = NULL, 
                               background = "white", delay = 0.2)
{
  w <- as.htmlwidget(f, width = width, height = height)
  path <- html_print(w, background = background, viewer = NULL)
  url <- paste0("file:///", gsub("\\\\", "/", normalizePath(path)))
  webshot(url,
          file = file,
          selector = ".formattable_widget",
          delay = delay)
}


export_formattable(tb, here("figures","tb.png"))
