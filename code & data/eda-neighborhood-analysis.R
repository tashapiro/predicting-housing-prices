library(tidyverse)
library(ggplot2)

df = read.csv("datasets/train.csv")


df <- df%>%
  mutate(
    neigh = case_when(
      Neighborhood=='Blmngtn'~'Bloomington Heights',
      Neighborhood=='Blueste'~'Bluestem',
      Neighborhood=='BrDale'~'Briar Dale',
      Neighborhood=='BrkSide'~'Brookside',
      Neighborhood=='ClearCr'~'Clear Creek',
      Neighborhood=='CollgCr'~'College Creek',
      Neighborhood=='Crawfor'~'Crawford',
      Neighborhood=='GrnHill'~'Green Hills',
      Neighborhood=='Landmrk'~'Landmark',
      Neighborhood=='MeadowV'~'Meadow Village',
      Neighborhood=='Mitchel'~'Mitchell',
      Neighborhood=='NAmes'~'North Ames',
      Neighborhood=='NoRidge'~'Northridge',
      Neighborhood=='NPkVill'~'Northpark Villa',
      Neighborhood=='NridgHt'~'Northridge Heights',
      Neighborhood=='NWAmes'~'Northwest Ames',
      Neighborhood=='OldTown'~'Old Town',
      Neighborhood=='SawyerW'~'Sawyer West',
      Neighborhood=='Somerst'~'Somerset',
      Neighborhood=='StoneBr'~'Stone Brook',
      Neighborhood=='Timber'~'Timberland',
      Neighborhood=='IDOTRR'~'Iowa Dot & RR',
      Neighborhood=='SWISU'~'SW of Iowa State Univ',
      TRUE~Neighborhood
    )
  )

df <- df%>%filter(Gr.Live.Area<4500)

col_line = '#5C5C5C'

#size and neighborhood plot
ggplot(df)+
  geom_point(aes(x=Gr.Liv.Area, y=SalePrice/1000, fill=Year.Built), 
             color="#212121", stroke = 0.2, shape=21, size=1.5)+
  scale_fill_viridis_c(option="plasma",
                       limits = c(1900,2008), breaks = c(1900, 1920, 1940, 1960, 1980, 2000),
                       labels = c("<1900","1920", "1940", "1960", "1980", "2000"),
                       na.value = '#170F88',
                       guide = guide_colourbar(title.position = "top",
                                    barheight=0.4,
                                    barwidth=12,
                                    title="Year Built",
                                    title.hjust =0.5))+
  facet_wrap(~neigh)+
  labs(
    y="Sale Price (thousands $)",
    x= "Above Ground Living Area (sqft)",
    fill="Year Built",
    title= "Size & Price by Neighborhood",
    caption = "Data from Ames Iowa Housing Dataset"
   # subtitle="Size & Price by Neighborhood"
  )+
  xlim(0,4000)+
  theme_minimal()+
  theme(text=element_text(family="Gill Sans",color="white"),
        legend.position = "top",
        axis.text = element_text(color="white"),
        axis.title.x = element_text(margin=margin(15,0,10,0)),
        axis.title.y = element_text(margin=margin(0,15,0,10)),
        strip.text = element_text(color="white"),
        axis.text.x=element_text(angle=90),
        plot.title=element_text(hjust=0.5),
        plot.subtitle=element_text(hjust=0.5),
        panel.grid.major=element_line(size=0.1,color=col_line),
        plot.margin = margin(10, 25, 10, 0),
        panel.grid.minor=element_blank(),
        plot.background = element_rect(fill="#212121", color="#212121"),
        panel.background = element_rect(fill="#212121",color="#212121"))

ggsave("neigh_size_price.jpeg", width = 9, height = 6)
