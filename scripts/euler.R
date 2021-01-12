# load the packages --------------------------------------------------------------------------

library(eulerr) # Area-Proportional Euler and Venn Diagrams with Ellipses
library(nVennR) # Create n-Dimensional, Quasi-Proportional Venn Diagrams (NOTE: needs also to download the rsvg and grImport2 packages)




# Byrne 2019 (3 SRs x 24 primary_studies) ----------------------------------------------------

CTT2012_2015 <- c("AFCAPS/TexCAPS", "ALERT", "ALLHAT-LLT", "ALLIANCE", "ASCOT-LLA", "ASPEN", "AURORA",
                   "CARDS", "CARE", "CORONA", "4D", "GISSI-HF", "GISSI-P", "HPS", "JUPITER", "LIPID",
                   "LIPS", "MEGA", "Post-GABG", "PROSPER", "4S", "WOSCOPS")


Mora2010 <- c("AFCAPS/TexCAPS", "JUPITER", "MEGA")


Ray2010 <- c("AFCAPS/TexCAPS", "ALLHAT-LLT", "ASCOT-LLA", "ASPEN",
                     "CARDS", "HYRIM", "JUPITER",
                     "MEGA", "PREVEND-IT","PROSPER", "WOSCOPS")



s2 <- list(CTT2012_2015 = CTT2012_2015,
           Mora2010 = Mora2010,
           Ray2010 = Ray2010)

set.seed(246)
plot(venn(s2), quantities = list(type = c("percent", "counts")))


set.seed(246)
plot(euler(s2, shape = "ellipse"), quantities = list(type = c("percent", "counts")))



set.seed(246)
myV2 <- plotVenn(s2, nCycles = 3000)

showSVG(myV2, opacity = 0.3, borderWidth = 2, outFile = "",
        systemShow = FALSE, labelRegions = T, showNumbers = T,
        setColors = NULL, fontScale = 2.5)




# Xing 2018  (4 SRs x 26 primary_studies) -----------------------------------------------------


Xia2017 <- c("Koh_Choi", "Koh", "Wong", "Tan", "Varma", "Orozco", "Gan")


Cui2016 <- c("Koh_Choi", "Koh", "Saw", "Wong", "Vangsness", "Varma", 
                     "Davatchi", "Emadedin", "Koh2", "Buda", "Gobbi", "Turajane", 
                     "Orozco2", "Kim", "Koh3", "Gobbi2", "Jo", "Kim2"
)

Yubo2017 <- c("Koh_Choi", "Koh", "Saw", "Vega", "Wong", "Tan", "Nejadnik", "Vangsness",
                      "Akgun", "Liang", "Lv")

Pas2016 <- c("Koh_Choi", "Koh", "Saw", "Vega", "Wong", "Tan")


s3 <- list(Xia2017 = Xia2017,
           Cui2016 = Cui2016,
           Yubo2017 = Yubo2017,
           Pas2016 = Pas2016)

set.seed(246)
plot(venn(s3), quantities = list(type = c("percent", "counts")))

set.seed(246)
plot(euler(s3, shape = "ellipse"), quantities = list(type = c("percent", "counts")))



set.seed(246)
myV3 <- plotVenn(s3, nCycles = 3000)

set.seed(246)
showSVG(myV3, opacity = 0.3, borderWidth = 2, outFile = "",
        systemShow = FALSE, labelRegions = T, showNumbers = T,
        setColors = NULL, fontScale = 2.5)





# Wells 2013  (5 SRs x 10 primary_studies) --------------------------------------------------

Aladro_Gonzalvo2012 <- c("Donzelli", "Gladwell", "da Fonseca", "Rydeard", 
                                 "Anderson","Gagnon", "MacIntyre",  "Quinn", "O’Brien")

La_Touche2008 <- c("Donzelli", "Gladwell", "Rydeard")

Lim2011 <- c("Donzelli", "Gladwell", "Rydeard", "Anderson","Gagnon", "Quinn", "O’Brien")

Pereira2012 <- c("Gladwell", "Rydeard", "Anderson","Gagnon", "O’Brien")

Posadzki2011 <- c("Donzelli", "Gladwell", "Rydeard", "Vad")



s4 <- list(Aladro_Gonzalvo2012 = Aladro_Gonzalvo2012,
           La_Touche2008 = La_Touche2008,
           Lim2011 = Lim2011,
           Pereira2012 = Pereira2012,
           Posadzki2011 = Posadzki2011)

set.seed(248)
plot(venn(s4), quantities = T)

set.seed(248)
plot(euler(s4, shape = "ellipse"), quantities = T)



set.seed(248)
myV4 <- plotVenn(s4, nCycles = 5000)

set.seed(248)
showSVG(myV4, opacity = 0.2, borderWidth = 3, outFile = "",
        systemShow = FALSE, labelRegions = T, showNumbers = T,
        setColors = NULL, fontScale = 2.5)
