# load the packages --------------------------------------------------------------------------
library(ggraph) # An Implementation of Grammar of Graphics for Graphs and Networks
library(geomnet) # Network Visualization in the 'ggplot2' Framework
library(network) # Classes for Relational Data
library(GGally) # Extension to 'ggplot2'
library(tidygraph) # A Tidy API for Graph Manipulation

library(here) # A Simpler Way to Find Your Files
library(tidyverse) # Easily Install and Load the 'Tidyverse'



# bipartite graphs ----------------------------------------------------------------------------

# load the data
library(readr) # Read Rectangular Text Data
citation_matrix_miyazaki <- read_delim(here("data", "miyazaki2017plain.csv"), 
                                       ";", escape_double = FALSE, trim_ws = TRUE)


bip = data.frame(citation_matrix_miyazaki[2:7],
                 row.names = citation_matrix_miyazaki$Primary_study)


# weighted bipartite network
bip1 = network(bip,
               matrix.type = "bipartite",
               ignore.eval = FALSE,
               names.eval = "weights")


# set colors for each mode
col = c("actor" = "grey70", "event" = "gold")


# detect and color the mode
set.seed(374)
net <- ggnet2(bip1, node.size =16, shape = 16, color.legend = NA, alpha = 0.7, max_size = 11,
              edge.size = 0.3, edge.alpha = 0.9,
              color = "mode", palette = col, label = TRUE)
net

# save image
#ggsave(here::here(paste0("net", format(Sys.time(), "%Y%m%d_%H%M%S"), ".png")), type = "cairo", width = 18, height = 10, dpi = 320)





# node-link graph (projection) ---------------------------------------------------------------------

id <- c(1:6)

label <- c("Chasan2014", "Gilinsky2015", "Guo2016", "Middleton2014", "Morton2014", "Peacock2014")


nodes <- tibble(id, label)



from <- c(
  1, 1, 1,
  1, 1, 2,
  2, 2, 2,
  3, 3, 3,
  4, 4, 5
)


to <- c(
  2, 3, 4,
  5, 6, 3,
  4, 5, 6,
  4, 5, 6,
  5, 6, 6
)


weight <- c(9, 9, NA, 
            3, 6, 10, 
            NA, 4, 6, 
            NA, 4, 6, 
            NA, NA, 1
)



edges <- tibble(from, to, weight)





net.tidy <- tbl_graph(
  nodes = nodes, edges = edges, directed = TRUE
)

Review.size <- c(9, 11, 12, 1, 4, 6)




# plot the node-link graph -------------------------------------------------------------------------
set.seed(268)
projection_net1 <- ggraph(net.tidy, layout = "graphopt") +
  geom_edge_link(aes(width = weight), color = "grey20", alpha = 0.9) + 
  geom_node_point(aes(size = Review.size), shape=21, fill = "gold", color = "grey20") +
  scale_size(range = c(6, 28), limits = c(0, 12), breaks = c(0, 2, 4, 6, 8, 10, 12)) +
  scale_edge_width(range = c(0.2, 10.0), limits = c(1, 14), breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) +
  geom_node_text(aes(label = label), color = "blue", size = 6, repel = TRUE) +
  labs(edge_width = "No. of primary studies \nin common") +
  theme_net() +
  theme(legend.title = element_text(size = 18),legend.position = c(1.2, 0.5),
        legend.key.size = unit(0.8, "cm"), legend.key.width = unit(1.0,"cm"),
        legend.text = element_text(size = 16))

projection_net1

#ggsave(here("projection_net1.png"), device = "png", type = "cairo", height = 11, width = 19)

