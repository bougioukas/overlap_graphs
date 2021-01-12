# load the packages ------------------------------------------------------------------
library(ComplexUpset)
library(tidyverse)
library(here)




# set new color palette -------------------------------------------------------------
library(paletteer)

scale_tableu <- function(){
  paletteer::scale_fill_paletteer_d("ggthemes::Tableau_20")
  
}

options(ggplot2.discrete.fill = scale_tableu)





# Miyazaki et al. study (overall, 6SRs x 14 RCTs) ------------------------------------------


# load and prepare the data

library(readr)
citation_matrix <- read_delim(here("data", "miyazaki2017plain.csv"), 
                               ";", escape_double = FALSE, trim_ws = TRUE)


citation_matrix <- as.data.frame(citation_matrix)


reviews <- colnames(citation_matrix)[2:7]
reviews



# convert the genre indicator columns to use boolean values

citation_matrix[reviews] <- citation_matrix[reviews] == 1
t(head(citation_matrix[reviews], 14))



# create the upset plot

miyazaki_upset_color <- upset(
  citation_matrix,
  reviews,
  base_annotations=list(
    'Intersection size'=intersection_size(
      counts=F,
      mapping=aes(fill= Primary_study)
      
    ) ),
  
  themes=upset_modify_themes(
    list('Intersection size'=theme(text=element_text(size=20)),
         'intersections_matrix'=theme(text=element_text(size=20, face= "bold"),
                                      axis.title.x=element_text(size = 18, face= "bold")),
         'overall_sizes'=theme(axis.text.x=element_text(size = 18, face= "bold"),
                               axis.title.x=element_text(size = 20, face= "bold"))
    )),
  
  set_sizes = (
    upset_set_size(geom=geom_bar(fill = "cornflowerblue", width = 0.5)) +
                 ylab('Number of included primary studies \n(set size)') +
                 scale_y_reverse(breaks = seq(0, 12, by = 2))),
               sort_sets="ascending", 
               width_ratio=0.3) +
    xlab("Exclusive intersection sets")

miyazaki_upset_color

#ggsave(here("miyazaki_upset_color.png"), device = "png", type = "cairo", dpi=400, height = 13, width = 22)






# Outcome: glycemic load (5SRs x 11 RCTs) --------------------------------------------------

# load and prepare the data
library(readr)
cm_glyc <- read_delim(here("data", "miyazaki2017_glycemic.csv"), 
                               ";", escape_double = FALSE, trim_ws = TRUE)


cm_glyc <- as.data.frame(cm_glyc)


reviews <- colnames(cm_glyc)[2:6]
reviews

cm_glyc[reviews] <- cm_glyc[reviews] == 1
t(cm_glyc[reviews])



# create the Upset plot for glycemic load

upset_glyc <- upset(
  cm_glyc,
  reviews,
  base_annotations = list(
    'Intersection size'= intersection_size(
      counts = F,
      mapping = aes(fill= Primary_study)
      
    ) ),
  
  themes=upset_modify_themes(
    list('Intersection size'=theme(text=element_text(size=20)),
         'intersections_matrix'=theme(text=element_text(size=20, face= "bold"),
                                      axis.title.x=element_text(size = 16, face= "bold")),
         'overall_sizes'=theme(axis.text.x=element_text(size = 18, face= "bold"),
                               axis.title.x=element_text(size = 20, face= "bold"))
    )),
  
  set_sizes = (
    upset_set_size(geom=geom_bar(fill = "cornflowerblue", width = 0.5)) +
      ylab('Number of included primary studies') +
      scale_y_reverse(breaks = seq(0, 10, by = 2))),
  sort_sets="ascending", 
  width_ratio=0.3) +
  xlab("Exclusive intersections")

upset_glyc

#ggsave(here("upset_glyc.png"), device = "png", type = "cairo", dpi=400, height = 13, width = 22)

