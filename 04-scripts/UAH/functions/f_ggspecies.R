ggspecies <- function (sp.id) {
  
  #' @description create a ggplot highlighting the species that interests you
  #' @author Julen Astigarraga
  #' @param sp.id species id
  #' @return a ggplot highlighting the species that interests you
  
  ggplot(df, aes(x = prod_year,
             y = prod_value,
             color = sites)) +
    geom_point(size = 0.1) + 
    scale_color_viridis_d() +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_discrete(labels = c("1", "2", "3")) +
    coord_cartesian(ylim = c(0, 120)) +
    ylab("Productivity") + 
    facet_grid(.~sites, switch = "x") +  
    gghighlight(species %in% sp.id,
                calculate_per_facet = TRUE,
                use_direct_label = FALSE) +
    ggtitle(sp.id, ) + 
    theme(legend.position = "none",
          title = element_text(colour = "black", size = 5),
          axis.title = element_text(colour = "black", size = 4),
          axis.text.y = element_text(colour = "black", size = 4),
          axis.text.x = element_text(colour = "black", size = 2),
          axis.title.x = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_line(colour = "black", size = 0.5), 
          strip.background = element_blank(),
          strip.placement = "outside",
          strip.text.x = element_text(size = 4))

}


