# load the packages

library(here)
library(tidyverse)
library(patchwork)


# miyazaki example (6SRs x 14 RCTs)  -----------------------------------------------------------

# load and read the data
library(readr)
cm <- read_delim(here("data", "miyazaki2017plain.csv"), ";", escape_double = FALSE, trim_ws = TRUE)



# prepare the data and 
cm <- cm %>% 
  dplyr::select(-Primary_study)


studies <- nrow(cm)
reviews <- ncol(cm)

counts <- c()
N <-c()
r<-c()
c<-c()
CCA_Proportion<-c()
CCA_Percentage<-c()

j <- t(combn(reviews,2))



# calculate the Corrected Cover Area (CCA)

for (i in 1:nrow(j)){
  
  cm2<-cm[j[i,]]
  
  reviews[i]<-paste(colnames(cm2[1]), "vs." ,colnames(cm2[2]))
  
  counts[i] <- nrow(cm2[as.logical(rowSums(cm2) == 2), ])
  
  N[i] <- sum(cm2)
  
  r[i] <- nrow(cm2[as.logical(rowSums(cm2 != 0)), ])
  
  c[i] <- ncol(cm2)
  
  CCA_Proportion[i] <- (N[i]-r[i])/((r[i]*c[i])-r[i])
  
  CCA_Percentage[i] <- round(CCA_Proportion[i]*100, digits = 1)
  
}



# create a table with all the parameters

tb <- tibble(reviews, counts, N, r, c, CCA_Proportion, CCA_Percentage)

j2 <- t(combn(colnames(cm),2))

colnames(j2) <- paste0("V", 1:2)

data_hm <- cbind(j2, tb)




# create a table with the number of primary studies for each SR

V3 <- colnames(cm)
V4 <- colnames(cm)
r2 <- c()
for (i in 1:ncol(cm)){
r2[i] <- sum(cm[i])
r2[i] <- paste(r2[i], "*")
} 


data_hm2 <- tibble(V3, V4, r2) 



# counts heatmap ------------------------------------------------------------------------------

heat_count <- ggplot(data = data_hm, aes(x = V1, y = V2)) +
  theme_classic(base_size = 20) +
  geom_tile(aes(fill = counts), color='grey70') +
  geom_tile(data = data_hm2, aes(x = V3, y = V4), fill = "grey", color='grey', inherit.aes = F) +
  coord_equal() +
  geom_text(aes(color = counts > 5, label = round(counts, 2)), size = 7) +
  geom_text(data = data_hm2, aes(x = V3, y = V4),  label = r2, size = 7, inherit.aes = F) +
  scale_fill_gradient(low="white", limits = c(0, 12), 
                      breaks=c(0, 2, 4, 6, 8, 10, 12), high="darkmagenta", 
                      name = "Degree of overlap \n(no. of primary studies \nin common)") +
  scale_color_manual(guide = FALSE, values = c("black", "white")) +
  labs(caption = "*total number of primary studies included in the review") +
  theme(
    plot.caption = element_text(size = 18, margin=margin(30,0,0,0)),
    legend.title = element_text(size = 18, face = "bold", vjust=4), 
    legend.text = element_text(size = 18),
    legend.key.size = unit(1.0, "cm"),
    legend.title.align = 0.5,
    legend.text.align = 0.5,
    axis.text.x=element_text(angle=40, vjust = 0.5, hjust=0.3, size = 18),
    axis.text.y=element_text(size = 18),
    axis.title=element_blank(),
    axis.ticks=element_blank(),
    axis.line=element_blank(),
    panel.border=element_blank(),
    panel.grid.major.x=element_line(colour = "grey80", linetype = "dashed"))

heat_count




# CCA heatmap --------------------------------------------------------------------------------

heat_CCA <- ggplot(data = data_hm, aes(x = V1, y = V2)) +
  theme_classic(base_size = 20) +
  geom_tile(aes(fill = CCA_Percentage), color='grey') +
  geom_tile(data = data_hm2, aes(x = V3, y = V4), fill = "grey", color='grey', inherit.aes = F) +
  coord_equal() +
  geom_text(aes(color = CCA_Percentage > 60, label = round(CCA_Percentage, 2)), size = 7) +
  geom_text(data = data_hm2, aes(x = V3, y = V4),  label = r2, size = 7, inherit.aes = F) +
  scale_fill_gradient(low="white", limits = c(0, 100), 
                      breaks=c(0, 20, 40, 60, 80, 100), high="#527e11", 
                      name = "CCA (%)") +
  scale_color_manual(guide = FALSE, values = c("black", "white")) +
  labs(caption = "*total number of primary studies included in the review \nCCA: Corrected Covered Area") +
  theme(
    plot.caption = element_text(size = 18, margin=margin(30,0,0,0)),
    legend.title = element_text(size = 18, face = "bold", vjust=4), 
    legend.text = element_text(size = 18),
    legend.key.size = unit(1.0, "cm"),
    legend.title.align = 0.5,
    legend.text.align = 0.5,
    axis.text.x=element_text(angle=40, vjust = 0.5, hjust=0.3, size = 18),
    axis.text.y=element_text(size = 18),
    axis.title=element_blank(),
    axis.ticks=element_blank(),
    axis.line=element_blank(),
    panel.border=element_blank(),
    panel.grid.major.x=element_line(colour = "grey80", linetype = "dashed"))

heat_CCA

heat_miyazaki <- heat_count + heat_CCA +
plot_annotation(tag_levels = 'A') & 
  theme(plot.tag = element_text(size = 24, face= "bold"))

heat_miyazaki


# save image
#ggsave(here::here(paste0("heat_miyazaki", format(Sys.time(), "%Y%m%d_%H%M%S"), ".png")), type = "cairo", width = 24, height = 10, dpi = 320)
