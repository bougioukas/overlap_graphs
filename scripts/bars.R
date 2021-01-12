# load the packages ------------------------------------------------------------------------
library(ggcharts) # Shorten the Distance from Data Visualization Idea to Actual Plot
library(here) # A Simpler Way to Find Your Files
library(tidyverse) # Easily Install and Load the 'Tidyverse'




# load and prepare the data -------------------------------------------------------------------

library(readr) # Read Rectangular Text Data
citation_matrix <- read_delim("data/miyazaki2017bars.csv", 
                                           ";", escape_double = FALSE, trim_ws = TRUE)

data1 <- pivot_longer(citation_matrix, cols = c(2:7),
                        names_to = "Review", values_to = "overlap")


data2 <- data1 %>%
  count(Review, overlap)


data2 <- data2 %>%
  mutate(overlap = factor(overlap,
                          levels = c("not included", "multiple", "single")))




# stacked bar for Miyazaki et al. study ---------------------------------------------------

stack_bar <- ggplot(data2, aes(x = Review, y = n, fill = overlap)) +
  geom_col(position = "stack", width = 0.6) +
  geom_text(aes(color = n < 2, label=n), size = 6.5, position = position_stack(vjust = 0.5)) +
  scale_fill_viridis_d(option = "D") +
  scale_color_manual(guide = FALSE, values = c("white", "black")) +
  theme_ggcharts(axis = "y", grid = "Y") +
  labs(x = "Systematic Reviews (m=6)", y = "Number of Primary Studies (n=14)",
       fill = "Primary studies") +
  theme(text = element_text(size = 13), title = element_text(size = 14),
        legend.title = element_text(size = 18, face = "bold", vjust=3), 
        legend.text = element_text(size = 18),
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 20, face = "bold")) +
  coord_flip()

stack_bar

#ggsave(here("stack_bar.png"), device = "png", type = "cairo", dpi= 420, height = 10, width = 20)

