Introduction to The Tidyverse for data analyses
================
Julen Astigarraga
15/06/2022

-   [Problem we are going to work
    with](#problem-we-are-going-to-work-with)
    -   [Download data](#download-data)
-   [The Tidyverse](#the-tidyverse)
    -   [1\| readr (read rectangular
        data)](#1-readr-read-rectangular-data)
    -   [2\| tibble (modern reimagining of the
        data.frame)](#2-tibble-modern-reimagining-of-the-dataframe)
    -   [3\| tidyr (tidy data)](#3-tidyr-tidy-data)
    -   [4\| dplyr (data manipulation)](#4-dplyr-data-manipulation)
    -   [5\| ggplot (data visualisation)](#5-ggplot-data-visualisation)
    -   [6\| stringr (string
        manipulation)](#6-stringr-string-manipulation)
    -   [7\| forcats (solve problems with
        factors)](#7-forcats-solve-problems-with-factors)
    -   [8\| purrr (functional
        programming)](#8-purrr-functional-programming)
    -   [Recommended reading](#recommended-reading)

<style type="text/css">
h1 {
    font-size: 20px;
}
h2 {
    font-size: 16px;
}
pre {
  font-size: 12px
}
body {
    font-size: 12px
}
</style>

<img src="../../04-output/figures_tidyverse/01-tidydata.jpg" title="by Allison Horst" alt="by Allison Horst" style="display: block; margin: auto;" />

In this R Markdown file you will find the basic concepts to understand
the core tidyverse collection of R packages
(<https://www.tidyverse.org/>)

# Problem we are going to work with

In the city council of Sevilla there are still discrepancies about the
existence of anthropogenic climate change. Some parties are of the
opinion that it does not exist, others think that it exists but that it
is not due to anthropogenic causes and others argue that all the
scientific evidence leaves no doubt that it exists and that it is due to
anthropogenic causes. The parties that believe that anthropogenic
climate change exists have asked you, a group of experts, to produce a
report that clearly shows how the increase in CO\~2\~ emissions has gone
hand in hand with the increase in temperature in recent decades. How
would you solve this issue?

-   The data could be obtained, for example, from the following
    information sources: Climate data for Sevilla:
    <https://verughub.github.io/easyclimate/index.html>

-   CO\~2\~ emissions data for Spain:
    <https://edgar.jrc.ec.europa.eu/report_2020#data_download>

<img src="../../04-output/figures_tidyverse/02-framework.jpg" title="Wickham &amp; Grolemund (2017)" alt="Wickham &amp; Grolemund (2017)" style="display: block; margin: auto;" />

## Download data

``` r
coords <- data.frame(
  lon = -5.99629,
  lat = 37.3826
)

ggplot() +
  borders(regions = c("Spain", "Portugal", "France")) +
  geom_point(data = coords, aes(x = lon, y = lat)) +
  coord_fixed(xlim = c(-10, 2), ylim = c(36, 44), ratio = 1.3) +
  xlab("Longitude") +
  ylab("Latitude") +
  theme_bw()
```

![](C:\Users\julen\OneDrive%20-%20Universidad%20de%20Alcala\species-ranges\coding-support-group\intro_tidyverse\05-final_docs_files/figure-gfm/download-1.png)<!-- -->

``` r
# tmin <- get_daily_climate(
#   coords,
#   period = 1950:2020,
#   climatic_var = "Tmin"
#   )
# 
# tmax <- get_daily_climate(
#   coords,
#   period = 1950:2020,
#   climatic_var = "Tmax"
#   )

# saveRDS(tmin, file = here("00-raw", "tmin_sevilla.rds"))
# saveRDS(tmax, file = here("00-raw", "tmax_sevilla.rds"))
```

# The Tidyverse

<img src="../../04-output/figures_tidyverse/03-tidyverse-packages.png" style="display: block; margin: auto;" />

> The tidyverse is an opinionated collection of R packages designed for
> data science. All packages share an underlying design philosophy,
> grammar, and data structures. —
> [tidyverse](https://www.tidyverse.org/)

> The tidyverse is fundamentally human centred (Wickham et al. JOSS,
> 2019) —

📝 *few advantages compared to base R*

## 1\| readr (read rectangular data)

-   📝 Use a consistent naming scheme for the parameters (e.g. col_names
    and col_types not header and colClasses)
-   Are much faster (up to 10x)

1.  Read CO\~2\~ and temperature data

``` r
co_data <- read_csv(here("01-data", "co2.csv"))
tmin_data <- readRDS(file = here("01-data", "tmin_sevilla.rds"))
tmax_data <- readRDS(file = here("01-data", "tmax_sevilla.rds"))
```

``` r
glimpse(co_data)
```

    ## Rows: 1,036
    ## Columns: 52
    ## $ Sector       <chr> "Buildings", "Buildings", "Buildings"…
    ## $ country_name <chr> "Afghanistan", "Albania", "Algeria", …
    ## $ `1970`       <chr> "0.58", "0.99", "1.81", "0.12", "0.00…
    ## $ `1971`       <chr> "0.58", "0.99", "1.81", "0.12", "0.00…
    ## $ `1972`       <chr> "0.46", "1.10", "2.11", "0.14", "0.00…
    ## $ `1973`       <chr> "0.57", "1.30", "2.51", "0.14", "0.00…
    ## $ `1974`       <chr> "0.77", "1.41", "2.68", "0.13", "0.00…
    ## $ `1975`       <chr> "0.59", "1.75", "2.97", "0.12", "0.00…
    ## $ `1976`       <chr> "0.48", "1.91", "3.79", "0.09", "0.00…
    ## $ `1977`       <chr> "0.43", "2.02", "3.80", "0.10", "0.00…
    ## $ `1978`       <chr> "0.41", "2.21", "4.46", "0.33", "0.00…
    ## $ `1979`       <chr> "0.48", "2.69", "5.16", "0.56", "0.00…
    ## $ `1980`       <chr> "0.45", "1.73", "5.37", "0.70", "0.00…
    ## $ `1981`       <chr> "0.52", "1.81", "5.84", "0.66", "0.00…
    ## $ `1982`       <chr> "0.60", "1.90", "6.24", "0.38", "0.00…
    ## $ `1983`       <chr> "0.94", "2.01", "7.04", "0.50", "0.00…
    ## $ `1984`       <chr> "0.99", "2.06", "7.76", "0.55", "0.00…
    ## $ `1985`       <chr> "1.28", "2.09", "4.87", "0.60", "0.00…
    ## $ `1986`       <chr> "1.20", "2.20", "5.60", "0.62", "0.00…
    ## $ `1987`       <chr> "0.79", "2.20", "6.01", "0.63", "0.00…
    ## $ `1988`       <chr> "0.85", "2.33", "6.03", "0.75", "0.00…
    ## $ `1989`       <chr> "0.98", "1.53", "6.76", "0.73", "0.00…
    ## $ `1990`       <chr> "1.04", "2.09", "6.59", "0.66", "0.00…
    ## $ `1991`       <chr> "0.99", "1.32", "7.54", "0.69", "0.00…
    ## $ `1992`       <chr> "0.69", "0.57", "7.78", "0.62", "0.00…
    ## $ `1993`       <chr> "0.60", "0.39", "8.23", "0.51", "0.00…
    ## $ `1994`       <chr> "0.63", "0.33", "8.17", "0.63", "0.00…
    ## $ `1995`       <chr> "0.36", "0.33", "8.09", "0.67", "0.00…
    ## $ `1996`       <chr> "0.33", "0.45", "8.31", "0.91", "0.00…
    ## $ `1997`       <chr> "0.36", "0.38", "7.98", "0.91", "0.00…
    ## $ `1998`       <chr> "0.29", "0.29", "8.63", "1.01", "0.00…
    ## $ `1999`       <chr> "0.29", "0.75", "9.09", "1.26", "0.00…
    ## $ `2000`       <chr> "0.21", "0.76", "9.33", "1.05", "0.00…
    ## $ `2001`       <chr> "0.12", "0.80", "9.53", "1.17", "0.00…
    ## $ `2002`       <chr> "0.05", "1.17", "9.89", "1.20", "0.00…
    ## $ `2003`       <chr> "0.03", "1.04", "10.68", "1.26", "0.0…
    ## $ `2004`       <chr> "0.04", "0.88", "11.51", "1.30", "0.0…
    ## $ `2005`       <chr> "0.08", "0.70", "12.50", "1.00", "0.0…
    ## $ `2006`       <chr> "0.11", "0.93", "12.19", "1.96", "0.0…
    ## $ `2007`       <chr> "0.16", "0.72", "13.60", "2.33", "0.0…
    ## $ `2008`       <chr> "0.32", "0.65", "13.57", "2.97", "0.0…
    ## $ `2009`       <chr> "0.47", "0.55", "17.40", "3.51", "0.0…
    ## $ `2010`       <chr> "0.65", "0.56", "16.80", "3.77", "0.0…
    ## $ `2011`       <chr> "0.75", "0.56", "18.57", "4.15", "0.0…
    ## $ `2012`       <chr> "0.75", "0.49", "20.33", "4.61", "0.0…
    ## $ `2013`       <chr> "0.92", "0.56", "22.60", "5.69", "0.0…
    ## $ `2014`       <chr> "0.85", "0.62", "21.57", "5.61", "0.0…
    ## $ `2015`       <chr> "0.86", "0.63", "23.51", "5.06", "0.0…
    ## $ `2016`       <chr> "0.80", "0.62", "23.19", "5.03", "0.0…
    ## $ `2017`       <chr> "0.84", "0.70", "23.91", "4.14", "0.0…
    ## $ `2018`       <chr> "0.86781928", "0.70320991", "25.88257…
    ## $ `2019`       <chr> "0.89489653", "0.71658967", "27.08971…

``` r
head(co_data)
tail(co_data)
summary(co_data)
```

    ##     Sector          country_name           1970          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1971               1972               1973          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1974               1975               1976          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1977               1978               1979          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1980               1981               1982          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1983               1984               1985          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1986               1987               1988          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1989               1990               1991          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1992               1993               1994          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1995               1996               1997          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      1998               1999               2000          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      2001               2002               2003          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      2004               2005               2006          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      2007               2008               2009          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      2010               2011               2012          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      2013               2014               2015          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      2016               2017               2018          
    ##  Length:1036        Length:1036        Length:1036       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##      2019          
    ##  Length:1036       
    ##  Class :character  
    ##  Mode  :character

``` r
names(co_data)
```

    ##  [1] "Sector"       "country_name" "1970"        
    ##  [4] "1971"         "1972"         "1973"        
    ##  [7] "1974"         "1975"         "1976"        
    ## [10] "1977"         "1978"         "1979"        
    ## [13] "1980"         "1981"         "1982"        
    ## [16] "1983"         "1984"         "1985"        
    ## [19] "1986"         "1987"         "1988"        
    ## [22] "1989"         "1990"         "1991"        
    ## [25] "1992"         "1993"         "1994"        
    ## [28] "1995"         "1996"         "1997"        
    ## [31] "1998"         "1999"         "2000"        
    ## [34] "2001"         "2002"         "2003"        
    ## [37] "2004"         "2005"         "2006"        
    ## [40] "2007"         "2008"         "2009"        
    ## [43] "2010"         "2011"         "2012"        
    ## [46] "2013"         "2014"         "2015"        
    ## [49] "2016"         "2017"         "2018"        
    ## [52] "2019"

``` r
glimpse(tmin_data)
```

    ## Rows: 25,933
    ## Columns: 5
    ## $ ID_coords <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ lon       <dbl> -5.99629, -5.99629, -5.99629, -5.99629, …
    ## $ lat       <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.3…
    ## $ date      <chr> "1950-01-01", "1950-01-02", "1950-01-03"…
    ## $ Tmin      <dbl> 6.74, 6.46, 5.46, 3.76, 4.65, 6.57, 5.64…

``` r
glimpse(tmax_data)
```

    ## Rows: 25,933
    ## Columns: 5
    ## $ ID_coords <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ lon       <dbl> -5.99629, -5.99629, -5.99629, -5.99629, …
    ## $ lat       <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.3…
    ## $ date      <chr> "1950-01-01", "1950-01-02", "1950-01-03"…
    ## $ Tmax      <dbl> 16.84, 16.99, 15.95, 18.68, 18.41, 15.73…

## 2\| tibble (modern reimagining of the data.frame)

-   📝 Allow to work with list-columns
-   Assists the user in displaying the printing
-   Never do partial matching

``` r
class(co_data)
```

    ## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"

``` r
co_data_df <- as.data.frame(co_data)
co_data <- as_tibble(co_data)

co_data_df$Secto
```

    ##    [1] "Buildings"                  
    ##    [2] "Buildings"                  
    ##    [3] "Buildings"                  
    ##    [4] "Buildings"                  
    ##    [5] "Buildings"                  
    ##    [6] "Buildings"                  
    ##    [7] "Buildings"                  
    ##    [8] "Buildings"                  
    ##    [9] "Buildings"                  
    ##   [10] "Buildings"                  
    ##   [11] "Buildings"                  
    ##   [12] "Buildings"                  
    ##   [13] "Buildings"                  
    ##   [14] "Buildings"                  
    ##   [15] "Buildings"                  
    ##   [16] "Buildings"                  
    ##   [17] "Buildings"                  
    ##   [18] "Buildings"                  
    ##   [19] "Buildings"                  
    ##   [20] "Buildings"                  
    ##   [21] "Buildings"                  
    ##   [22] "Buildings"                  
    ##   [23] "Buildings"                  
    ##   [24] "Buildings"                  
    ##   [25] "Buildings"                  
    ##   [26] "Buildings"                  
    ##   [27] "Buildings"                  
    ##   [28] "Buildings"                  
    ##   [29] "Buildings"                  
    ##   [30] "Buildings"                  
    ##   [31] "Buildings"                  
    ##   [32] "Buildings"                  
    ##   [33] "Buildings"                  
    ##   [34] "Buildings"                  
    ##   [35] "Buildings"                  
    ##   [36] "Buildings"                  
    ##   [37] "Buildings"                  
    ##   [38] "Buildings"                  
    ##   [39] "Buildings"                  
    ##   [40] "Buildings"                  
    ##   [41] "Buildings"                  
    ##   [42] "Buildings"                  
    ##   [43] "Buildings"                  
    ##   [44] "Buildings"                  
    ##   [45] "Buildings"                  
    ##   [46] "Buildings"                  
    ##   [47] "Buildings"                  
    ##   [48] "Buildings"                  
    ##   [49] "Buildings"                  
    ##   [50] "Buildings"                  
    ##   [51] "Buildings"                  
    ##   [52] "Buildings"                  
    ##   [53] "Buildings"                  
    ##   [54] "Buildings"                  
    ##   [55] "Buildings"                  
    ##   [56] "Buildings"                  
    ##   [57] "Buildings"                  
    ##   [58] "Buildings"                  
    ##   [59] "Buildings"                  
    ##   [60] "Buildings"                  
    ##   [61] "Buildings"                  
    ##   [62] "Buildings"                  
    ##   [63] "Buildings"                  
    ##   [64] "Buildings"                  
    ##   [65] "Buildings"                  
    ##   [66] "Buildings"                  
    ##   [67] "Buildings"                  
    ##   [68] "Buildings"                  
    ##   [69] "Buildings"                  
    ##   [70] "Buildings"                  
    ##   [71] "Buildings"                  
    ##   [72] "Buildings"                  
    ##   [73] "Buildings"                  
    ##   [74] "Buildings"                  
    ##   [75] "Buildings"                  
    ##   [76] "Buildings"                  
    ##   [77] "Buildings"                  
    ##   [78] "Buildings"                  
    ##   [79] "Buildings"                  
    ##   [80] "Buildings"                  
    ##   [81] "Buildings"                  
    ##   [82] "Buildings"                  
    ##   [83] "Buildings"                  
    ##   [84] "Buildings"                  
    ##   [85] "Buildings"                  
    ##   [86] "Buildings"                  
    ##   [87] "Buildings"                  
    ##   [88] "Buildings"                  
    ##   [89] "Buildings"                  
    ##   [90] "Buildings"                  
    ##   [91] "Buildings"                  
    ##   [92] "Buildings"                  
    ##   [93] "Buildings"                  
    ##   [94] "Buildings"                  
    ##   [95] "Buildings"                  
    ##   [96] "Buildings"                  
    ##   [97] "Buildings"                  
    ##   [98] "Buildings"                  
    ##   [99] "Buildings"                  
    ##  [100] "Buildings"                  
    ##  [101] "Buildings"                  
    ##  [102] "Buildings"                  
    ##  [103] "Buildings"                  
    ##  [104] "Buildings"                  
    ##  [105] "Buildings"                  
    ##  [106] "Buildings"                  
    ##  [107] "Buildings"                  
    ##  [108] "Buildings"                  
    ##  [109] "Buildings"                  
    ##  [110] "Buildings"                  
    ##  [111] "Buildings"                  
    ##  [112] "Buildings"                  
    ##  [113] "Buildings"                  
    ##  [114] "Buildings"                  
    ##  [115] "Buildings"                  
    ##  [116] "Buildings"                  
    ##  [117] "Buildings"                  
    ##  [118] "Buildings"                  
    ##  [119] "Buildings"                  
    ##  [120] "Buildings"                  
    ##  [121] "Buildings"                  
    ##  [122] "Buildings"                  
    ##  [123] "Buildings"                  
    ##  [124] "Buildings"                  
    ##  [125] "Buildings"                  
    ##  [126] "Buildings"                  
    ##  [127] "Buildings"                  
    ##  [128] "Buildings"                  
    ##  [129] "Buildings"                  
    ##  [130] "Buildings"                  
    ##  [131] "Buildings"                  
    ##  [132] "Buildings"                  
    ##  [133] "Buildings"                  
    ##  [134] "Buildings"                  
    ##  [135] "Buildings"                  
    ##  [136] "Buildings"                  
    ##  [137] "Buildings"                  
    ##  [138] "Buildings"                  
    ##  [139] "Buildings"                  
    ##  [140] "Buildings"                  
    ##  [141] "Buildings"                  
    ##  [142] "Buildings"                  
    ##  [143] "Buildings"                  
    ##  [144] "Buildings"                  
    ##  [145] "Buildings"                  
    ##  [146] "Buildings"                  
    ##  [147] "Buildings"                  
    ##  [148] "Buildings"                  
    ##  [149] "Buildings"                  
    ##  [150] "Buildings"                  
    ##  [151] "Buildings"                  
    ##  [152] "Buildings"                  
    ##  [153] "Buildings"                  
    ##  [154] "Buildings"                  
    ##  [155] "Buildings"                  
    ##  [156] "Buildings"                  
    ##  [157] "Buildings"                  
    ##  [158] "Buildings"                  
    ##  [159] "Buildings"                  
    ##  [160] "Buildings"                  
    ##  [161] "Buildings"                  
    ##  [162] "Buildings"                  
    ##  [163] "Buildings"                  
    ##  [164] "Buildings"                  
    ##  [165] "Buildings"                  
    ##  [166] "Buildings"                  
    ##  [167] "Buildings"                  
    ##  [168] "Buildings"                  
    ##  [169] "Buildings"                  
    ##  [170] "Buildings"                  
    ##  [171] "Buildings"                  
    ##  [172] "Buildings"                  
    ##  [173] "Buildings"                  
    ##  [174] "Buildings"                  
    ##  [175] "Buildings"                  
    ##  [176] "Buildings"                  
    ##  [177] "Buildings"                  
    ##  [178] "Buildings"                  
    ##  [179] "Buildings"                  
    ##  [180] "Buildings"                  
    ##  [181] "Buildings"                  
    ##  [182] "Buildings"                  
    ##  [183] "Buildings"                  
    ##  [184] "Buildings"                  
    ##  [185] "Buildings"                  
    ##  [186] "Buildings"                  
    ##  [187] "Buildings"                  
    ##  [188] "Buildings"                  
    ##  [189] "Buildings"                  
    ##  [190] "Buildings"                  
    ##  [191] "Buildings"                  
    ##  [192] "Buildings"                  
    ##  [193] "Buildings"                  
    ##  [194] "Buildings"                  
    ##  [195] "Buildings"                  
    ##  [196] "Buildings"                  
    ##  [197] "Buildings"                  
    ##  [198] "Buildings"                  
    ##  [199] "Buildings"                  
    ##  [200] "Buildings"                  
    ##  [201] "Buildings"                  
    ##  [202] "Buildings"                  
    ##  [203] "Buildings"                  
    ##  [204] "Buildings"                  
    ##  [205] "Buildings"                  
    ##  [206] "Buildings"                  
    ##  [207] "Other sectors"              
    ##  [208] "Other sectors"              
    ##  [209] "Other sectors"              
    ##  [210] "Other sectors"              
    ##  [211] "Other sectors"              
    ##  [212] "Other sectors"              
    ##  [213] "Other sectors"              
    ##  [214] "Other sectors"              
    ##  [215] "Other sectors"              
    ##  [216] "Other sectors"              
    ##  [217] "Other sectors"              
    ##  [218] "Other sectors"              
    ##  [219] "Other sectors"              
    ##  [220] "Other sectors"              
    ##  [221] "Other sectors"              
    ##  [222] "Other sectors"              
    ##  [223] "Other sectors"              
    ##  [224] "Other sectors"              
    ##  [225] "Other sectors"              
    ##  [226] "Other sectors"              
    ##  [227] "Other sectors"              
    ##  [228] "Other sectors"              
    ##  [229] "Other sectors"              
    ##  [230] "Other sectors"              
    ##  [231] "Other sectors"              
    ##  [232] "Other sectors"              
    ##  [233] "Other sectors"              
    ##  [234] "Other sectors"              
    ##  [235] "Other sectors"              
    ##  [236] "Other sectors"              
    ##  [237] "Other sectors"              
    ##  [238] "Other sectors"              
    ##  [239] "Other sectors"              
    ##  [240] "Other sectors"              
    ##  [241] "Other sectors"              
    ##  [242] "Other sectors"              
    ##  [243] "Other sectors"              
    ##  [244] "Other sectors"              
    ##  [245] "Other sectors"              
    ##  [246] "Other sectors"              
    ##  [247] "Other sectors"              
    ##  [248] "Other sectors"              
    ##  [249] "Other sectors"              
    ##  [250] "Other sectors"              
    ##  [251] "Other sectors"              
    ##  [252] "Other sectors"              
    ##  [253] "Other sectors"              
    ##  [254] "Other sectors"              
    ##  [255] "Other sectors"              
    ##  [256] "Other sectors"              
    ##  [257] "Other sectors"              
    ##  [258] "Other sectors"              
    ##  [259] "Other sectors"              
    ##  [260] "Other sectors"              
    ##  [261] "Other sectors"              
    ##  [262] "Other sectors"              
    ##  [263] "Other sectors"              
    ##  [264] "Other sectors"              
    ##  [265] "Other sectors"              
    ##  [266] "Other sectors"              
    ##  [267] "Other sectors"              
    ##  [268] "Other sectors"              
    ##  [269] "Other sectors"              
    ##  [270] "Other sectors"              
    ##  [271] "Other sectors"              
    ##  [272] "Other sectors"              
    ##  [273] "Other sectors"              
    ##  [274] "Other sectors"              
    ##  [275] "Other sectors"              
    ##  [276] "Other sectors"              
    ##  [277] "Other sectors"              
    ##  [278] "Other sectors"              
    ##  [279] "Other sectors"              
    ##  [280] "Other sectors"              
    ##  [281] "Other sectors"              
    ##  [282] "Other sectors"              
    ##  [283] "Other sectors"              
    ##  [284] "Other sectors"              
    ##  [285] "Other sectors"              
    ##  [286] "Other sectors"              
    ##  [287] "Other sectors"              
    ##  [288] "Other sectors"              
    ##  [289] "Other sectors"              
    ##  [290] "Other sectors"              
    ##  [291] "Other sectors"              
    ##  [292] "Other sectors"              
    ##  [293] "Other sectors"              
    ##  [294] "Other sectors"              
    ##  [295] "Other sectors"              
    ##  [296] "Other sectors"              
    ##  [297] "Other sectors"              
    ##  [298] "Other sectors"              
    ##  [299] "Other sectors"              
    ##  [300] "Other sectors"              
    ##  [301] "Other sectors"              
    ##  [302] "Other sectors"              
    ##  [303] "Other sectors"              
    ##  [304] "Other sectors"              
    ##  [305] "Other sectors"              
    ##  [306] "Other sectors"              
    ##  [307] "Other sectors"              
    ##  [308] "Other sectors"              
    ##  [309] "Other sectors"              
    ##  [310] "Other sectors"              
    ##  [311] "Other sectors"              
    ##  [312] "Other sectors"              
    ##  [313] "Other sectors"              
    ##  [314] "Other sectors"              
    ##  [315] "Other sectors"              
    ##  [316] "Other sectors"              
    ##  [317] "Other sectors"              
    ##  [318] "Other sectors"              
    ##  [319] "Other sectors"              
    ##  [320] "Other sectors"              
    ##  [321] "Other sectors"              
    ##  [322] "Other sectors"              
    ##  [323] "Other sectors"              
    ##  [324] "Other sectors"              
    ##  [325] "Other sectors"              
    ##  [326] "Other sectors"              
    ##  [327] "Other sectors"              
    ##  [328] "Other sectors"              
    ##  [329] "Other sectors"              
    ##  [330] "Other sectors"              
    ##  [331] "Other sectors"              
    ##  [332] "Other sectors"              
    ##  [333] "Other sectors"              
    ##  [334] "Other sectors"              
    ##  [335] "Other sectors"              
    ##  [336] "Other sectors"              
    ##  [337] "Other sectors"              
    ##  [338] "Other sectors"              
    ##  [339] "Other sectors"              
    ##  [340] "Other sectors"              
    ##  [341] "Other sectors"              
    ##  [342] "Other sectors"              
    ##  [343] "Other sectors"              
    ##  [344] "Other sectors"              
    ##  [345] "Other sectors"              
    ##  [346] "Other sectors"              
    ##  [347] "Other sectors"              
    ##  [348] "Other sectors"              
    ##  [349] "Other sectors"              
    ##  [350] "Other sectors"              
    ##  [351] "Other sectors"              
    ##  [352] "Other sectors"              
    ##  [353] "Other sectors"              
    ##  [354] "Other sectors"              
    ##  [355] "Other sectors"              
    ##  [356] "Other sectors"              
    ##  [357] "Other sectors"              
    ##  [358] "Other sectors"              
    ##  [359] "Other sectors"              
    ##  [360] "Other sectors"              
    ##  [361] "Other sectors"              
    ##  [362] "Other sectors"              
    ##  [363] "Other sectors"              
    ##  [364] "Other sectors"              
    ##  [365] "Other sectors"              
    ##  [366] "Other sectors"              
    ##  [367] "Other sectors"              
    ##  [368] "Other sectors"              
    ##  [369] "Other sectors"              
    ##  [370] "Other sectors"              
    ##  [371] "Other sectors"              
    ##  [372] "Other sectors"              
    ##  [373] "Other sectors"              
    ##  [374] "Other sectors"              
    ##  [375] "Other sectors"              
    ##  [376] "Other sectors"              
    ##  [377] "Other sectors"              
    ##  [378] "Other sectors"              
    ##  [379] "Other sectors"              
    ##  [380] "Other sectors"              
    ##  [381] "Other sectors"              
    ##  [382] "Other sectors"              
    ##  [383] "Other sectors"              
    ##  [384] "Other sectors"              
    ##  [385] "Other sectors"              
    ##  [386] "Other sectors"              
    ##  [387] "Other sectors"              
    ##  [388] "Other sectors"              
    ##  [389] "Other sectors"              
    ##  [390] "Other sectors"              
    ##  [391] "Other sectors"              
    ##  [392] "Other sectors"              
    ##  [393] "Other sectors"              
    ##  [394] "Other sectors"              
    ##  [395] "Other sectors"              
    ##  [396] "Other sectors"              
    ##  [397] "Other sectors"              
    ##  [398] "Other sectors"              
    ##  [399] "Other sectors"              
    ##  [400] "Other sectors"              
    ##  [401] "Other sectors"              
    ##  [402] "Other sectors"              
    ##  [403] "Other sectors"              
    ##  [404] "Other sectors"              
    ##  [405] "Other sectors"              
    ##  [406] "Other sectors"              
    ##  [407] "Other sectors"              
    ##  [408] "Other sectors"              
    ##  [409] "Other sectors"              
    ##  [410] "Other sectors"              
    ##  [411] "Other sectors"              
    ##  [412] "Other sectors"              
    ##  [413] "Other sectors"              
    ##  [414] "Other sectors"              
    ##  [415] "Other industrial combustion"
    ##  [416] "Other industrial combustion"
    ##  [417] "Other industrial combustion"
    ##  [418] "Other industrial combustion"
    ##  [419] "Other industrial combustion"
    ##  [420] "Other industrial combustion"
    ##  [421] "Other industrial combustion"
    ##  [422] "Other industrial combustion"
    ##  [423] "Other industrial combustion"
    ##  [424] "Other industrial combustion"
    ##  [425] "Other industrial combustion"
    ##  [426] "Other industrial combustion"
    ##  [427] "Other industrial combustion"
    ##  [428] "Other industrial combustion"
    ##  [429] "Other industrial combustion"
    ##  [430] "Other industrial combustion"
    ##  [431] "Other industrial combustion"
    ##  [432] "Other industrial combustion"
    ##  [433] "Other industrial combustion"
    ##  [434] "Other industrial combustion"
    ##  [435] "Other industrial combustion"
    ##  [436] "Other industrial combustion"
    ##  [437] "Other industrial combustion"
    ##  [438] "Other industrial combustion"
    ##  [439] "Other industrial combustion"
    ##  [440] "Other industrial combustion"
    ##  [441] "Other industrial combustion"
    ##  [442] "Other industrial combustion"
    ##  [443] "Other industrial combustion"
    ##  [444] "Other industrial combustion"
    ##  [445] "Other industrial combustion"
    ##  [446] "Other industrial combustion"
    ##  [447] "Other industrial combustion"
    ##  [448] "Other industrial combustion"
    ##  [449] "Other industrial combustion"
    ##  [450] "Other industrial combustion"
    ##  [451] "Other industrial combustion"
    ##  [452] "Other industrial combustion"
    ##  [453] "Other industrial combustion"
    ##  [454] "Other industrial combustion"
    ##  [455] "Other industrial combustion"
    ##  [456] "Other industrial combustion"
    ##  [457] "Other industrial combustion"
    ##  [458] "Other industrial combustion"
    ##  [459] "Other industrial combustion"
    ##  [460] "Other industrial combustion"
    ##  [461] "Other industrial combustion"
    ##  [462] "Other industrial combustion"
    ##  [463] "Other industrial combustion"
    ##  [464] "Other industrial combustion"
    ##  [465] "Other industrial combustion"
    ##  [466] "Other industrial combustion"
    ##  [467] "Other industrial combustion"
    ##  [468] "Other industrial combustion"
    ##  [469] "Other industrial combustion"
    ##  [470] "Other industrial combustion"
    ##  [471] "Other industrial combustion"
    ##  [472] "Other industrial combustion"
    ##  [473] "Other industrial combustion"
    ##  [474] "Other industrial combustion"
    ##  [475] "Other industrial combustion"
    ##  [476] "Other industrial combustion"
    ##  [477] "Other industrial combustion"
    ##  [478] "Other industrial combustion"
    ##  [479] "Other industrial combustion"
    ##  [480] "Other industrial combustion"
    ##  [481] "Other industrial combustion"
    ##  [482] "Other industrial combustion"
    ##  [483] "Other industrial combustion"
    ##  [484] "Other industrial combustion"
    ##  [485] "Other industrial combustion"
    ##  [486] "Other industrial combustion"
    ##  [487] "Other industrial combustion"
    ##  [488] "Other industrial combustion"
    ##  [489] "Other industrial combustion"
    ##  [490] "Other industrial combustion"
    ##  [491] "Other industrial combustion"
    ##  [492] "Other industrial combustion"
    ##  [493] "Other industrial combustion"
    ##  [494] "Other industrial combustion"
    ##  [495] "Other industrial combustion"
    ##  [496] "Other industrial combustion"
    ##  [497] "Other industrial combustion"
    ##  [498] "Other industrial combustion"
    ##  [499] "Other industrial combustion"
    ##  [500] "Other industrial combustion"
    ##  [501] "Other industrial combustion"
    ##  [502] "Other industrial combustion"
    ##  [503] "Other industrial combustion"
    ##  [504] "Other industrial combustion"
    ##  [505] "Other industrial combustion"
    ##  [506] "Other industrial combustion"
    ##  [507] "Other industrial combustion"
    ##  [508] "Other industrial combustion"
    ##  [509] "Other industrial combustion"
    ##  [510] "Other industrial combustion"
    ##  [511] "Other industrial combustion"
    ##  [512] "Other industrial combustion"
    ##  [513] "Other industrial combustion"
    ##  [514] "Other industrial combustion"
    ##  [515] "Other industrial combustion"
    ##  [516] "Other industrial combustion"
    ##  [517] "Other industrial combustion"
    ##  [518] "Other industrial combustion"
    ##  [519] "Other industrial combustion"
    ##  [520] "Other industrial combustion"
    ##  [521] "Other industrial combustion"
    ##  [522] "Other industrial combustion"
    ##  [523] "Other industrial combustion"
    ##  [524] "Other industrial combustion"
    ##  [525] "Other industrial combustion"
    ##  [526] "Other industrial combustion"
    ##  [527] "Other industrial combustion"
    ##  [528] "Other industrial combustion"
    ##  [529] "Other industrial combustion"
    ##  [530] "Other industrial combustion"
    ##  [531] "Other industrial combustion"
    ##  [532] "Other industrial combustion"
    ##  [533] "Other industrial combustion"
    ##  [534] "Other industrial combustion"
    ##  [535] "Other industrial combustion"
    ##  [536] "Other industrial combustion"
    ##  [537] "Other industrial combustion"
    ##  [538] "Other industrial combustion"
    ##  [539] "Other industrial combustion"
    ##  [540] "Other industrial combustion"
    ##  [541] "Other industrial combustion"
    ##  [542] "Other industrial combustion"
    ##  [543] "Other industrial combustion"
    ##  [544] "Other industrial combustion"
    ##  [545] "Other industrial combustion"
    ##  [546] "Other industrial combustion"
    ##  [547] "Other industrial combustion"
    ##  [548] "Other industrial combustion"
    ##  [549] "Other industrial combustion"
    ##  [550] "Other industrial combustion"
    ##  [551] "Other industrial combustion"
    ##  [552] "Other industrial combustion"
    ##  [553] "Other industrial combustion"
    ##  [554] "Other industrial combustion"
    ##  [555] "Other industrial combustion"
    ##  [556] "Other industrial combustion"
    ##  [557] "Other industrial combustion"
    ##  [558] "Other industrial combustion"
    ##  [559] "Other industrial combustion"
    ##  [560] "Other industrial combustion"
    ##  [561] "Other industrial combustion"
    ##  [562] "Other industrial combustion"
    ##  [563] "Other industrial combustion"
    ##  [564] "Other industrial combustion"
    ##  [565] "Other industrial combustion"
    ##  [566] "Other industrial combustion"
    ##  [567] "Other industrial combustion"
    ##  [568] "Other industrial combustion"
    ##  [569] "Other industrial combustion"
    ##  [570] "Other industrial combustion"
    ##  [571] "Other industrial combustion"
    ##  [572] "Other industrial combustion"
    ##  [573] "Other industrial combustion"
    ##  [574] "Other industrial combustion"
    ##  [575] "Other industrial combustion"
    ##  [576] "Other industrial combustion"
    ##  [577] "Other industrial combustion"
    ##  [578] "Other industrial combustion"
    ##  [579] "Other industrial combustion"
    ##  [580] "Other industrial combustion"
    ##  [581] "Other industrial combustion"
    ##  [582] "Other industrial combustion"
    ##  [583] "Other industrial combustion"
    ##  [584] "Other industrial combustion"
    ##  [585] "Other industrial combustion"
    ##  [586] "Other industrial combustion"
    ##  [587] "Other industrial combustion"
    ##  [588] "Other industrial combustion"
    ##  [589] "Other industrial combustion"
    ##  [590] "Other industrial combustion"
    ##  [591] "Other industrial combustion"
    ##  [592] "Other industrial combustion"
    ##  [593] "Other industrial combustion"
    ##  [594] "Other industrial combustion"
    ##  [595] "Other industrial combustion"
    ##  [596] "Other industrial combustion"
    ##  [597] "Other industrial combustion"
    ##  [598] "Other industrial combustion"
    ##  [599] "Other industrial combustion"
    ##  [600] "Other industrial combustion"
    ##  [601] "Other industrial combustion"
    ##  [602] "Other industrial combustion"
    ##  [603] "Other industrial combustion"
    ##  [604] "Other industrial combustion"
    ##  [605] "Other industrial combustion"
    ##  [606] "Other industrial combustion"
    ##  [607] "Other industrial combustion"
    ##  [608] "Other industrial combustion"
    ##  [609] "Other industrial combustion"
    ##  [610] "Other industrial combustion"
    ##  [611] "Other industrial combustion"
    ##  [612] "Other industrial combustion"
    ##  [613] "Other industrial combustion"
    ##  [614] "Other industrial combustion"
    ##  [615] "Other industrial combustion"
    ##  [616] "Other industrial combustion"
    ##  [617] "Other industrial combustion"
    ##  [618] "Other industrial combustion"
    ##  [619] "Other industrial combustion"
    ##  [620] "Other industrial combustion"
    ##  [621] "Power Industry"             
    ##  [622] "Power Industry"             
    ##  [623] "Power Industry"             
    ##  [624] "Power Industry"             
    ##  [625] "Power Industry"             
    ##  [626] "Power Industry"             
    ##  [627] "Power Industry"             
    ##  [628] "Power Industry"             
    ##  [629] "Power Industry"             
    ##  [630] "Power Industry"             
    ##  [631] "Power Industry"             
    ##  [632] "Power Industry"             
    ##  [633] "Power Industry"             
    ##  [634] "Power Industry"             
    ##  [635] "Power Industry"             
    ##  [636] "Power Industry"             
    ##  [637] "Power Industry"             
    ##  [638] "Power Industry"             
    ##  [639] "Power Industry"             
    ##  [640] "Power Industry"             
    ##  [641] "Power Industry"             
    ##  [642] "Power Industry"             
    ##  [643] "Power Industry"             
    ##  [644] "Power Industry"             
    ##  [645] "Power Industry"             
    ##  [646] "Power Industry"             
    ##  [647] "Power Industry"             
    ##  [648] "Power Industry"             
    ##  [649] "Power Industry"             
    ##  [650] "Power Industry"             
    ##  [651] "Power Industry"             
    ##  [652] "Power Industry"             
    ##  [653] "Power Industry"             
    ##  [654] "Power Industry"             
    ##  [655] "Power Industry"             
    ##  [656] "Power Industry"             
    ##  [657] "Power Industry"             
    ##  [658] "Power Industry"             
    ##  [659] "Power Industry"             
    ##  [660] "Power Industry"             
    ##  [661] "Power Industry"             
    ##  [662] "Power Industry"             
    ##  [663] "Power Industry"             
    ##  [664] "Power Industry"             
    ##  [665] "Power Industry"             
    ##  [666] "Power Industry"             
    ##  [667] "Power Industry"             
    ##  [668] "Power Industry"             
    ##  [669] "Power Industry"             
    ##  [670] "Power Industry"             
    ##  [671] "Power Industry"             
    ##  [672] "Power Industry"             
    ##  [673] "Power Industry"             
    ##  [674] "Power Industry"             
    ##  [675] "Power Industry"             
    ##  [676] "Power Industry"             
    ##  [677] "Power Industry"             
    ##  [678] "Power Industry"             
    ##  [679] "Power Industry"             
    ##  [680] "Power Industry"             
    ##  [681] "Power Industry"             
    ##  [682] "Power Industry"             
    ##  [683] "Power Industry"             
    ##  [684] "Power Industry"             
    ##  [685] "Power Industry"             
    ##  [686] "Power Industry"             
    ##  [687] "Power Industry"             
    ##  [688] "Power Industry"             
    ##  [689] "Power Industry"             
    ##  [690] "Power Industry"             
    ##  [691] "Power Industry"             
    ##  [692] "Power Industry"             
    ##  [693] "Power Industry"             
    ##  [694] "Power Industry"             
    ##  [695] "Power Industry"             
    ##  [696] "Power Industry"             
    ##  [697] "Power Industry"             
    ##  [698] "Power Industry"             
    ##  [699] "Power Industry"             
    ##  [700] "Power Industry"             
    ##  [701] "Power Industry"             
    ##  [702] "Power Industry"             
    ##  [703] "Power Industry"             
    ##  [704] "Power Industry"             
    ##  [705] "Power Industry"             
    ##  [706] "Power Industry"             
    ##  [707] "Power Industry"             
    ##  [708] "Power Industry"             
    ##  [709] "Power Industry"             
    ##  [710] "Power Industry"             
    ##  [711] "Power Industry"             
    ##  [712] "Power Industry"             
    ##  [713] "Power Industry"             
    ##  [714] "Power Industry"             
    ##  [715] "Power Industry"             
    ##  [716] "Power Industry"             
    ##  [717] "Power Industry"             
    ##  [718] "Power Industry"             
    ##  [719] "Power Industry"             
    ##  [720] "Power Industry"             
    ##  [721] "Power Industry"             
    ##  [722] "Power Industry"             
    ##  [723] "Power Industry"             
    ##  [724] "Power Industry"             
    ##  [725] "Power Industry"             
    ##  [726] "Power Industry"             
    ##  [727] "Power Industry"             
    ##  [728] "Power Industry"             
    ##  [729] "Power Industry"             
    ##  [730] "Power Industry"             
    ##  [731] "Power Industry"             
    ##  [732] "Power Industry"             
    ##  [733] "Power Industry"             
    ##  [734] "Power Industry"             
    ##  [735] "Power Industry"             
    ##  [736] "Power Industry"             
    ##  [737] "Power Industry"             
    ##  [738] "Power Industry"             
    ##  [739] "Power Industry"             
    ##  [740] "Power Industry"             
    ##  [741] "Power Industry"             
    ##  [742] "Power Industry"             
    ##  [743] "Power Industry"             
    ##  [744] "Power Industry"             
    ##  [745] "Power Industry"             
    ##  [746] "Power Industry"             
    ##  [747] "Power Industry"             
    ##  [748] "Power Industry"             
    ##  [749] "Power Industry"             
    ##  [750] "Power Industry"             
    ##  [751] "Power Industry"             
    ##  [752] "Power Industry"             
    ##  [753] "Power Industry"             
    ##  [754] "Power Industry"             
    ##  [755] "Power Industry"             
    ##  [756] "Power Industry"             
    ##  [757] "Power Industry"             
    ##  [758] "Power Industry"             
    ##  [759] "Power Industry"             
    ##  [760] "Power Industry"             
    ##  [761] "Power Industry"             
    ##  [762] "Power Industry"             
    ##  [763] "Power Industry"             
    ##  [764] "Power Industry"             
    ##  [765] "Power Industry"             
    ##  [766] "Power Industry"             
    ##  [767] "Power Industry"             
    ##  [768] "Power Industry"             
    ##  [769] "Power Industry"             
    ##  [770] "Power Industry"             
    ##  [771] "Power Industry"             
    ##  [772] "Power Industry"             
    ##  [773] "Power Industry"             
    ##  [774] "Power Industry"             
    ##  [775] "Power Industry"             
    ##  [776] "Power Industry"             
    ##  [777] "Power Industry"             
    ##  [778] "Power Industry"             
    ##  [779] "Power Industry"             
    ##  [780] "Power Industry"             
    ##  [781] "Power Industry"             
    ##  [782] "Power Industry"             
    ##  [783] "Power Industry"             
    ##  [784] "Power Industry"             
    ##  [785] "Power Industry"             
    ##  [786] "Power Industry"             
    ##  [787] "Power Industry"             
    ##  [788] "Power Industry"             
    ##  [789] "Power Industry"             
    ##  [790] "Power Industry"             
    ##  [791] "Power Industry"             
    ##  [792] "Power Industry"             
    ##  [793] "Power Industry"             
    ##  [794] "Power Industry"             
    ##  [795] "Power Industry"             
    ##  [796] "Power Industry"             
    ##  [797] "Power Industry"             
    ##  [798] "Power Industry"             
    ##  [799] "Power Industry"             
    ##  [800] "Power Industry"             
    ##  [801] "Power Industry"             
    ##  [802] "Power Industry"             
    ##  [803] "Power Industry"             
    ##  [804] "Power Industry"             
    ##  [805] "Power Industry"             
    ##  [806] "Power Industry"             
    ##  [807] "Power Industry"             
    ##  [808] "Power Industry"             
    ##  [809] "Power Industry"             
    ##  [810] "Power Industry"             
    ##  [811] "Power Industry"             
    ##  [812] "Power Industry"             
    ##  [813] "Power Industry"             
    ##  [814] "Power Industry"             
    ##  [815] "Power Industry"             
    ##  [816] "Power Industry"             
    ##  [817] "Power Industry"             
    ##  [818] "Power Industry"             
    ##  [819] "Power Industry"             
    ##  [820] "Power Industry"             
    ##  [821] "Power Industry"             
    ##  [822] "Power Industry"             
    ##  [823] "Power Industry"             
    ##  [824] "Power Industry"             
    ##  [825] "Power Industry"             
    ##  [826] "Power Industry"             
    ##  [827] "Power Industry"             
    ##  [828] "Transport"                  
    ##  [829] "Transport"                  
    ##  [830] "Transport"                  
    ##  [831] "Transport"                  
    ##  [832] "Transport"                  
    ##  [833] "Transport"                  
    ##  [834] "Transport"                  
    ##  [835] "Transport"                  
    ##  [836] "Transport"                  
    ##  [837] "Transport"                  
    ##  [838] "Transport"                  
    ##  [839] "Transport"                  
    ##  [840] "Transport"                  
    ##  [841] "Transport"                  
    ##  [842] "Transport"                  
    ##  [843] "Transport"                  
    ##  [844] "Transport"                  
    ##  [845] "Transport"                  
    ##  [846] "Transport"                  
    ##  [847] "Transport"                  
    ##  [848] "Transport"                  
    ##  [849] "Transport"                  
    ##  [850] "Transport"                  
    ##  [851] "Transport"                  
    ##  [852] "Transport"                  
    ##  [853] "Transport"                  
    ##  [854] "Transport"                  
    ##  [855] "Transport"                  
    ##  [856] "Transport"                  
    ##  [857] "Transport"                  
    ##  [858] "Transport"                  
    ##  [859] "Transport"                  
    ##  [860] "Transport"                  
    ##  [861] "Transport"                  
    ##  [862] "Transport"                  
    ##  [863] "Transport"                  
    ##  [864] "Transport"                  
    ##  [865] "Transport"                  
    ##  [866] "Transport"                  
    ##  [867] "Transport"                  
    ##  [868] "Transport"                  
    ##  [869] "Transport"                  
    ##  [870] "Transport"                  
    ##  [871] "Transport"                  
    ##  [872] "Transport"                  
    ##  [873] "Transport"                  
    ##  [874] "Transport"                  
    ##  [875] "Transport"                  
    ##  [876] "Transport"                  
    ##  [877] "Transport"                  
    ##  [878] "Transport"                  
    ##  [879] "Transport"                  
    ##  [880] "Transport"                  
    ##  [881] "Transport"                  
    ##  [882] "Transport"                  
    ##  [883] "Transport"                  
    ##  [884] "Transport"                  
    ##  [885] "Transport"                  
    ##  [886] "Transport"                  
    ##  [887] "Transport"                  
    ##  [888] "Transport"                  
    ##  [889] "Transport"                  
    ##  [890] "Transport"                  
    ##  [891] "Transport"                  
    ##  [892] "Transport"                  
    ##  [893] "Transport"                  
    ##  [894] "Transport"                  
    ##  [895] "Transport"                  
    ##  [896] "Transport"                  
    ##  [897] "Transport"                  
    ##  [898] "Transport"                  
    ##  [899] "Transport"                  
    ##  [900] "Transport"                  
    ##  [901] "Transport"                  
    ##  [902] "Transport"                  
    ##  [903] "Transport"                  
    ##  [904] "Transport"                  
    ##  [905] "Transport"                  
    ##  [906] "Transport"                  
    ##  [907] "Transport"                  
    ##  [908] "Transport"                  
    ##  [909] "Transport"                  
    ##  [910] "Transport"                  
    ##  [911] "Transport"                  
    ##  [912] "Transport"                  
    ##  [913] "Transport"                  
    ##  [914] "Transport"                  
    ##  [915] "Transport"                  
    ##  [916] "Transport"                  
    ##  [917] "Transport"                  
    ##  [918] "Transport"                  
    ##  [919] "Transport"                  
    ##  [920] "Transport"                  
    ##  [921] "Transport"                  
    ##  [922] "Transport"                  
    ##  [923] "Transport"                  
    ##  [924] "Transport"                  
    ##  [925] "Transport"                  
    ##  [926] "Transport"                  
    ##  [927] "Transport"                  
    ##  [928] "Transport"                  
    ##  [929] "Transport"                  
    ##  [930] "Transport"                  
    ##  [931] "Transport"                  
    ##  [932] "Transport"                  
    ##  [933] "Transport"                  
    ##  [934] "Transport"                  
    ##  [935] "Transport"                  
    ##  [936] "Transport"                  
    ##  [937] "Transport"                  
    ##  [938] "Transport"                  
    ##  [939] "Transport"                  
    ##  [940] "Transport"                  
    ##  [941] "Transport"                  
    ##  [942] "Transport"                  
    ##  [943] "Transport"                  
    ##  [944] "Transport"                  
    ##  [945] "Transport"                  
    ##  [946] "Transport"                  
    ##  [947] "Transport"                  
    ##  [948] "Transport"                  
    ##  [949] "Transport"                  
    ##  [950] "Transport"                  
    ##  [951] "Transport"                  
    ##  [952] "Transport"                  
    ##  [953] "Transport"                  
    ##  [954] "Transport"                  
    ##  [955] "Transport"                  
    ##  [956] "Transport"                  
    ##  [957] "Transport"                  
    ##  [958] "Transport"                  
    ##  [959] "Transport"                  
    ##  [960] "Transport"                  
    ##  [961] "Transport"                  
    ##  [962] "Transport"                  
    ##  [963] "Transport"                  
    ##  [964] "Transport"                  
    ##  [965] "Transport"                  
    ##  [966] "Transport"                  
    ##  [967] "Transport"                  
    ##  [968] "Transport"                  
    ##  [969] "Transport"                  
    ##  [970] "Transport"                  
    ##  [971] "Transport"                  
    ##  [972] "Transport"                  
    ##  [973] "Transport"                  
    ##  [974] "Transport"                  
    ##  [975] "Transport"                  
    ##  [976] "Transport"                  
    ##  [977] "Transport"                  
    ##  [978] "Transport"                  
    ##  [979] "Transport"                  
    ##  [980] "Transport"                  
    ##  [981] "Transport"                  
    ##  [982] "Transport"                  
    ##  [983] "Transport"                  
    ##  [984] "Transport"                  
    ##  [985] "Transport"                  
    ##  [986] "Transport"                  
    ##  [987] "Transport"                  
    ##  [988] "Transport"                  
    ##  [989] "Transport"                  
    ##  [990] "Transport"                  
    ##  [991] "Transport"                  
    ##  [992] "Transport"                  
    ##  [993] "Transport"                  
    ##  [994] "Transport"                  
    ##  [995] "Transport"                  
    ##  [996] "Transport"                  
    ##  [997] "Transport"                  
    ##  [998] "Transport"                  
    ##  [999] "Transport"                  
    ## [1000] "Transport"                  
    ##  [ reached getOption("max.print") -- omitted 36 entries ]

``` r
co_data$Secto
```

    ## NULL

## 3\| tidyr (tidy data)

-   📝tidy data 3 characteristics:

1.  Every column is a variable
2.  Every row is an observation
3.  Every cell is a single measurement

🔎 [Check out this post by Julie Lowndes and Allison
Horst](https://www.openscapes.org/blog/2020/10/12/tidy-data/)

4\. Change CO\~2\~ annual data to long format

``` r
glimpse(co_data)
```

    ## Rows: 1,036
    ## Columns: 52
    ## $ Sector       <chr> "Buildings", "Buildings", "Buildings"…
    ## $ country_name <chr> "Afghanistan", "Albania", "Algeria", …
    ## $ `1970`       <chr> "0.58", "0.99", "1.81", "0.12", "0.00…
    ## $ `1971`       <chr> "0.58", "0.99", "1.81", "0.12", "0.00…
    ## $ `1972`       <chr> "0.46", "1.10", "2.11", "0.14", "0.00…
    ## $ `1973`       <chr> "0.57", "1.30", "2.51", "0.14", "0.00…
    ## $ `1974`       <chr> "0.77", "1.41", "2.68", "0.13", "0.00…
    ## $ `1975`       <chr> "0.59", "1.75", "2.97", "0.12", "0.00…
    ## $ `1976`       <chr> "0.48", "1.91", "3.79", "0.09", "0.00…
    ## $ `1977`       <chr> "0.43", "2.02", "3.80", "0.10", "0.00…
    ## $ `1978`       <chr> "0.41", "2.21", "4.46", "0.33", "0.00…
    ## $ `1979`       <chr> "0.48", "2.69", "5.16", "0.56", "0.00…
    ## $ `1980`       <chr> "0.45", "1.73", "5.37", "0.70", "0.00…
    ## $ `1981`       <chr> "0.52", "1.81", "5.84", "0.66", "0.00…
    ## $ `1982`       <chr> "0.60", "1.90", "6.24", "0.38", "0.00…
    ## $ `1983`       <chr> "0.94", "2.01", "7.04", "0.50", "0.00…
    ## $ `1984`       <chr> "0.99", "2.06", "7.76", "0.55", "0.00…
    ## $ `1985`       <chr> "1.28", "2.09", "4.87", "0.60", "0.00…
    ## $ `1986`       <chr> "1.20", "2.20", "5.60", "0.62", "0.00…
    ## $ `1987`       <chr> "0.79", "2.20", "6.01", "0.63", "0.00…
    ## $ `1988`       <chr> "0.85", "2.33", "6.03", "0.75", "0.00…
    ## $ `1989`       <chr> "0.98", "1.53", "6.76", "0.73", "0.00…
    ## $ `1990`       <chr> "1.04", "2.09", "6.59", "0.66", "0.00…
    ## $ `1991`       <chr> "0.99", "1.32", "7.54", "0.69", "0.00…
    ## $ `1992`       <chr> "0.69", "0.57", "7.78", "0.62", "0.00…
    ## $ `1993`       <chr> "0.60", "0.39", "8.23", "0.51", "0.00…
    ## $ `1994`       <chr> "0.63", "0.33", "8.17", "0.63", "0.00…
    ## $ `1995`       <chr> "0.36", "0.33", "8.09", "0.67", "0.00…
    ## $ `1996`       <chr> "0.33", "0.45", "8.31", "0.91", "0.00…
    ## $ `1997`       <chr> "0.36", "0.38", "7.98", "0.91", "0.00…
    ## $ `1998`       <chr> "0.29", "0.29", "8.63", "1.01", "0.00…
    ## $ `1999`       <chr> "0.29", "0.75", "9.09", "1.26", "0.00…
    ## $ `2000`       <chr> "0.21", "0.76", "9.33", "1.05", "0.00…
    ## $ `2001`       <chr> "0.12", "0.80", "9.53", "1.17", "0.00…
    ## $ `2002`       <chr> "0.05", "1.17", "9.89", "1.20", "0.00…
    ## $ `2003`       <chr> "0.03", "1.04", "10.68", "1.26", "0.0…
    ## $ `2004`       <chr> "0.04", "0.88", "11.51", "1.30", "0.0…
    ## $ `2005`       <chr> "0.08", "0.70", "12.50", "1.00", "0.0…
    ## $ `2006`       <chr> "0.11", "0.93", "12.19", "1.96", "0.0…
    ## $ `2007`       <chr> "0.16", "0.72", "13.60", "2.33", "0.0…
    ## $ `2008`       <chr> "0.32", "0.65", "13.57", "2.97", "0.0…
    ## $ `2009`       <chr> "0.47", "0.55", "17.40", "3.51", "0.0…
    ## $ `2010`       <chr> "0.65", "0.56", "16.80", "3.77", "0.0…
    ## $ `2011`       <chr> "0.75", "0.56", "18.57", "4.15", "0.0…
    ## $ `2012`       <chr> "0.75", "0.49", "20.33", "4.61", "0.0…
    ## $ `2013`       <chr> "0.92", "0.56", "22.60", "5.69", "0.0…
    ## $ `2014`       <chr> "0.85", "0.62", "21.57", "5.61", "0.0…
    ## $ `2015`       <chr> "0.86", "0.63", "23.51", "5.06", "0.0…
    ## $ `2016`       <chr> "0.80", "0.62", "23.19", "5.03", "0.0…
    ## $ `2017`       <chr> "0.84", "0.70", "23.91", "4.14", "0.0…
    ## $ `2018`       <chr> "0.86781928", "0.70320991", "25.88257…
    ## $ `2019`       <chr> "0.89489653", "0.71658967", "27.08971…

``` r
co_data_l <- co_data |>
  pivot_longer(
    cols = "1970":"2019",
    names_to = "co_year",
    values_to = "co_value"
  )

glimpse(co_data_l)
```

    ## Rows: 51,800
    ## Columns: 4
    ## $ Sector       <chr> "Buildings", "Buildings", "Buildings"…
    ## $ country_name <chr> "Afghanistan", "Afghanistan", "Afghan…
    ## $ co_year      <chr> "1970", "1971", "1972", "1973", "1974…
    ## $ co_value     <chr> "0.58", "0.58", "0.46", "0.57", "0.77…

## 4\| dplyr (data manipulation)

<img src="../../04-output/figures_tidyverse/04-dplyr.jpg" title="by Allison Horst" alt="by Allison Horst" style="display: block; margin: auto;" />

-   📝 consistent set of verbs
-   pipes (`%>%` &`|>`)

1.  Filter data from Spain
2.  Delete (not select) those variables that you’re not interested in

``` r
glimpse(co_data_l)
```

    ## Rows: 51,800
    ## Columns: 4
    ## $ Sector       <chr> "Buildings", "Buildings", "Buildings"…
    ## $ country_name <chr> "Afghanistan", "Afghanistan", "Afghan…
    ## $ co_year      <chr> "1970", "1971", "1972", "1973", "1974…
    ## $ co_value     <chr> "0.58", "0.58", "0.46", "0.57", "0.77…

``` r
co_data_l_sp <- co_data_l |>
  filter(country_name == "Spain and Andorra") |>
  select(!country_name)

glimpse(co_data_l_sp)
```

    ## Rows: 250
    ## Columns: 3
    ## $ Sector   <chr> "Buildings", "Buildings", "Buildings", "B…
    ## $ co_year  <chr> "1970", "1971", "1972", "1973", "1974", "…
    ## $ co_value <chr> "15.20", "16.85", "17.55", "16.11", "15.6…

``` r
glimpse(tmin_data)
```

    ## Rows: 25,933
    ## Columns: 5
    ## $ ID_coords <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ lon       <dbl> -5.99629, -5.99629, -5.99629, -5.99629, …
    ## $ lat       <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.3…
    ## $ date      <chr> "1950-01-01", "1950-01-02", "1950-01-03"…
    ## $ Tmin      <dbl> 6.74, 6.46, 5.46, 3.76, 4.65, 6.57, 5.64…

``` r
tmin_data_sel <- tmin_data |>
  select(!c(ID_coords))

tmax_data_sel <- tmax_data |>
  select(!c(ID_coords))

glimpse(tmin_data_sel)
```

    ## Rows: 25,933
    ## Columns: 4
    ## $ lon  <dbl> -5.99629, -5.99629, -5.99629, -5.99629, -5.99…
    ## $ lat  <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.3826, …
    ## $ date <chr> "1950-01-01", "1950-01-02", "1950-01-03", "19…
    ## $ Tmin <dbl> 6.74, 6.46, 5.46, 3.76, 4.65, 6.57, 5.64, 6.9…

``` r
glimpse(tmax_data_sel)
```

    ## Rows: 25,933
    ## Columns: 4
    ## $ lon  <dbl> -5.99629, -5.99629, -5.99629, -5.99629, -5.99…
    ## $ lat  <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.3826, …
    ## $ date <chr> "1950-01-01", "1950-01-02", "1950-01-03", "19…
    ## $ Tmax <dbl> 16.84, 16.99, 15.95, 18.68, 18.41, 15.73, 12.…

3\. Bind/Join both tmin and tmax data

``` r
temp_data <- bind_cols(tmin_data_sel, tmax_data_sel)
glimpse(temp_data)
```

    ## Rows: 25,933
    ## Columns: 8
    ## $ lon...1  <dbl> -5.99629, -5.99629, -5.99629, -5.99629, -…
    ## $ lat...2  <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.38…
    ## $ date...3 <chr> "1950-01-01", "1950-01-02", "1950-01-03",…
    ## $ Tmin     <dbl> 6.74, 6.46, 5.46, 3.76, 4.65, 6.57, 5.64,…
    ## $ lon...5  <dbl> -5.99629, -5.99629, -5.99629, -5.99629, -…
    ## $ lat...6  <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.38…
    ## $ date...7 <chr> "1950-01-01", "1950-01-02", "1950-01-03",…
    ## $ Tmax     <dbl> 16.84, 16.99, 15.95, 18.68, 18.41, 15.73,…

``` r
temp_data <- full_join(tmin_data_sel, tmax_data_sel,
                       by = c("lat", "lon", "date"))
glimpse(temp_data)
```

    ## Rows: 25,933
    ## Columns: 5
    ## $ lon  <dbl> -5.99629, -5.99629, -5.99629, -5.99629, -5.99…
    ## $ lat  <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.3826, …
    ## $ date <chr> "1950-01-01", "1950-01-02", "1950-01-03", "19…
    ## $ Tmin <dbl> 6.74, 6.46, 5.46, 3.76, 4.65, 6.57, 5.64, 6.9…
    ## $ Tmax <dbl> 16.84, 16.99, 15.95, 18.68, 18.41, 15.73, 12.…

4\. Create a new variable (column) with mutate to get mean temperature
data

``` r
daily_tmean <- temp_data %>%
  mutate(
    Tmean = (Tmin + Tmax) / 2,
    date = as.Date(date),
    month = format(date, format = "%m"),
    year = format(date, format = "%Y")
  )
```

5\. But wait! We’re interested in annual data not daily data

``` r
glimpse(co_data_l_sp)
```

    ## Rows: 250
    ## Columns: 3
    ## $ Sector   <chr> "Buildings", "Buildings", "Buildings", "B…
    ## $ co_year  <chr> "1970", "1971", "1972", "1973", "1974", "…
    ## $ co_value <chr> "15.20", "16.85", "17.55", "16.11", "15.6…

``` r
glimpse(daily_tmean)
```

    ## Rows: 25,933
    ## Columns: 8
    ## $ lon   <dbl> -5.99629, -5.99629, -5.99629, -5.99629, -5.9…
    ## $ lat   <dbl> 37.3826, 37.3826, 37.3826, 37.3826, 37.3826,…
    ## $ date  <date> 1950-01-01, 1950-01-02, 1950-01-03, 1950-01…
    ## $ Tmin  <dbl> 6.74, 6.46, 5.46, 3.76, 4.65, 6.57, 5.64, 6.…
    ## $ Tmax  <dbl> 16.84, 16.99, 15.95, 18.68, 18.41, 15.73, 12…
    ## $ Tmean <dbl> 11.790, 11.725, 10.705, 11.220, 11.530, 11.1…
    ## $ month <chr> "01", "01", "01", "01", "01", "01", "01", "0…
    ## $ year  <chr> "1950", "1950", "1950", "1950", "1950", "195…

``` r
annual <- daily_tmean |>
  group_by(year) |>
  summarise(
    Tmean.year = mean(Tmean)
    )

glimpse(annual)
```

    ## Rows: 71
    ## Columns: 2
    ## $ year       <chr> "1950", "1951", "1952", "1953", "1954",…
    ## $ Tmean.year <dbl> 18.93229, 18.15532, 17.99232, 18.84060,…

6\. Join both datasets and review what we have learned so far

``` r
co_temp <- full_join(
  co_data_l_sp, annual, by = c("co_year" = "year")
)

glimpse(co_temp)
```

    ## Rows: 271
    ## Columns: 4
    ## $ Sector     <chr> "Buildings", "Buildings", "Buildings", …
    ## $ co_year    <chr> "1970", "1971", "1972", "1973", "1974",…
    ## $ co_value   <chr> "15.20", "16.85", "17.55", "16.11", "15…
    ## $ Tmean.year <dbl> 18.15171, 17.49244, 17.33210, 17.97434,…

``` r
co_temp_all <- co_temp |>
  mutate(
    co_value = as.numeric(co_value),
    co_year = as.numeric(co_year),
  ) |>
  group_by(co_year) |>
  summarise(
    co_all = sum(co_value),
    Tmean.year = first(Tmean.year)
  )

glimpse(co_temp_all)
```

    ## Rows: 71
    ## Columns: 3
    ## $ co_year    <dbl> 1950, 1951, 1952, 1953, 1954, 1955, 195…
    ## $ co_all     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ Tmean.year <dbl> 18.93229, 18.15532, 17.99232, 18.84060,…

## 5\| ggplot (data visualisation)

📝 😨 ggplot2 is a system for declaratively creating graphics, based on
The Grammar of Graphics. You provide the data, tell ggplot2 how to map
variables to aesthetics, what graphical primitives to use, and it takes
care of the details.

1.  Visualise the relationship between annual CO\~2\~ emissions and
    years
2.  Visualise the relationship between annual mean temperature and years
3.  Visualise the relationship between annual CO\~2\~ emissions and mean
    temperature

``` r
gg_ye_co <- ggplot(co_temp_all, 
                   aes(x = co_year, y = co_all,
                       color = co_year)) +
  geom_line() +
  # geom_smooth(color = "#E1BE6A") +
  geom_smooth(method = "lm", color = "#40B0A6")

gg_ye_temp <- ggplot(co_temp_all, 
                     aes(x = co_year, y = Tmean.year,
                         color = co_year)) +
  geom_point() +
  # geom_smooth(color = "#E1BE6A") +
  geom_smooth(method = "lm", color = "#40B0A6")

gg_co_temp <- ggplot(co_temp_all, aes(x = co_all, y = Tmean.year)) +
  geom_point() +
  # geom_smooth(color = "#E1BE6A") +
  geom_smooth(method = "lm", color = "#40B0A6")


(gg_ye_co + gg_ye_temp) / gg_co_temp
```

![](C:\Users\julen\OneDrive%20-%20Universidad%20de%20Alcala\species-ranges\coding-support-group\intro_tidyverse\05-final_docs_files/figure-gfm/ggplot-1.png)<!-- -->

``` r
co_temp <- co_temp |>
  mutate(
    across(c(co_value, co_year), ~as.numeric(.x))
  )
```

## 6\| stringr (string manipulation)

-   📝 All functions in stringr start with str\_ and take a vector of
    strings as the first argument
-   Make working with strings as easy as possible

## 7\| forcats (solve problems with factors)

-   📝 Solve common problems with factors

1.  Detect and highlight all sectors starting with the word “Other”
2.  Put the sectors beginning with “Other” at the end of the legend

``` r
gg_ye_co_sec <- co_temp |>
  drop_na(Sector) |>
  ggplot(aes(x = co_year, y = co_value, color = Sector)) +
  geom_line()

co_temp_fs <- co_temp |>
  mutate(
    transport = str_detect(Sector, "Transport"),
    Sector = fct_relevel(Sector, "Other industrial combustion", after = Inf),
    Sector = fct_relevel(Sector, "Other sectors", after = Inf)
    )

glimpse(co_temp_fs)
```

    ## Rows: 271
    ## Columns: 5
    ## $ Sector     <fct> Buildings, Buildings, Buildings, Buildi…
    ## $ co_year    <dbl> 1970, 1971, 1972, 1973, 1974, 1975, 197…
    ## $ co_value   <dbl> 15.20, 16.85, 17.55, 16.11, 15.63, 16.5…
    ## $ Tmean.year <dbl> 18.15171, 17.49244, 17.33210, 17.97434,…
    ## $ transport  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…

``` r
gg_ye_co_sec <- co_temp_fs |>
  drop_na(Sector) |>
  ggplot(aes(x = co_year, y = co_value, color = Sector)) +
  geom_line() +
  geom_line(data = co_temp_fs |> filter(transport == T),
            aes(x = co_year, y = co_value, color = Sector),
            size = 1.5)

(gg_ye_co + gg_ye_co_sec) /
  (gg_ye_temp + gg_co_temp)
```

![](C:\Users\julen\OneDrive%20-%20Universidad%20de%20Alcala\species-ranges\coding-support-group\intro_tidyverse\05-final_docs_files/figure-gfm/stringr-forcats-1.png)<!-- -->

## 8\| purrr (functional programming)

-   📝 The idea of passing a function to another function is an
    extremely powerful idea, and it’s one of the behaviours that makes R
    a functional programming language.
-   Functional programming makes your code easier to write and to read
    (for loops are quite verbose, and require quite a bit of bookkeeping
    code that is duplicated for every for loop).
-   The apply family of functions in base R solve a similar problem, but
    purrr is more consistent and thus is easier to learn.

<img src="../../04-output/figures_tidyverse/05-forloops.png" title="Illustrations from Hadley Wickham's talk The Joy of Functional Programming (for Data Science)" alt="Illustrations from Hadley Wickham's talk The Joy of Functional Programming (for Data Science)" style="display: block; margin: auto;" /><img src="../../04-output/figures_tidyverse/06-map_frosting.png" title="Illustrations from Hadley Wickham's talk The Joy of Functional Programming (for Data Science)" alt="Illustrations from Hadley Wickham's talk The Joy of Functional Programming (for Data Science)" style="display: block; margin: auto;" />

1.  Create a function to add a theme to a ggplot
2.  Apply this function to all ggplots at once

-   🔎 [Check out this post by Rebecca
    Barter](https://www.rebeccabarter.com/blog/2019-08-19_purrr/)

``` r
glimpse(co_data_l)
```

    ## Rows: 51,800
    ## Columns: 4
    ## $ Sector       <chr> "Buildings", "Buildings", "Buildings"…
    ## $ country_name <chr> "Afghanistan", "Afghanistan", "Afghan…
    ## $ co_year      <chr> "1970", "1971", "1972", "1973", "1974…
    ## $ co_value     <chr> "0.58", "0.58", "0.46", "0.57", "0.77…

``` r
co_data_l[, "country_name"]

select_example <- function(dat, x){
  return(dat[, x])
}

select_example(co_data_l, "country_name")

gg_theme <- function(gg, units, title){
  gg +
    geom_smooth(method = "lm", color = "firebrick", size = 1.3) +
    stat_fit_glance(
        method = "lm",
        label.x = "left",
        label.y = "top",
        method.args = list(formula = y ~ x),
        mapping = aes(
          label = sprintf('italic(R^2)~"="~%.3f~~italic(P)~"="~%.2g',
                          after_stat(r.squared), after_stat(p.value))
        ),
        parse = TRUE
      ) +
    geom_point(alpha = .5) +
    scale_y_continuous(labels = function(x){paste0(x, units)}) +
    scale_color_viridis_c(option = "turbo", direction = -1,
                          name = NULL,
                          breaks = seq(1950, 2020, 10)) +
    guides(color = guide_colorsteps(barwidth = unit(30, "lines"),
                                    barheight = unit(.4, "lines"))) +
    labs(y = NULL, x = NULL,
         title = title) +
    theme(
      panel.grid.major = element_line(colour = "grey90", size = 0.5),
      panel.background = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "top",
      legend.title = element_text(size = 14, color = "grey20"),
      legend.text = element_text(size = 12, color = "grey50"),
      plot.title = element_text(size = 22, margin = margin(b = 15)),
      plot.subtitle = element_text(size = 14, margin = margin(b = 15)),
      plot.caption = element_text(size = 14, color = "grey50", margin = margin(t = 25)),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      axis.text = element_text(size = 14),
      axis.line.x = element_line(color = "grey20"),
      axis.ticks.x = element_line(color = "grey20"),
      plot.margin = margin(20, 20, 10, 20)
      )
}

gg_ye_temp_th <- gg_theme(
  gg = gg_ye_temp,
  units = "°C",
  title = "Annual mean temperature"
)

gg_ye_co_th <- gg_theme(
  gg = gg_ye_co,
  units = " Mt CO2/yr",
  title = bquote(Annual~CO[2]~emissions)
)

gg_co_temp_th <- gg_theme(
  gg = gg_co_temp,
  units = "°C",
  title = bquote(
    Annual~mean~temperature~vs~Annual~CO[2]~emissions
    )
) +
  scale_x_continuous(labels = function(x){paste0(x, " Mt CO2/yr")})

arg_3 <- list(
  gg = list(gg_ye_co, gg_ye_temp, gg_co_temp),
  units = c("°C", "Mt CO2/yr", "°C"),
  title = c(
    "Annual mean temperature",
    "Annual CO2 emissions",
    "Annual mean temperature vs Annual CO2 emissions"
  )
  )

arg_3 |>
  pmap(gg_theme) |>
  reduce(`+`)
```

![](C:\Users\julen\OneDrive%20-%20Universidad%20de%20Alcala\species-ranges\coding-support-group\intro_tidyverse\05-final_docs_files/figure-gfm/purrr-1.png)<!-- -->

``` r
gg_ye_co_sec_th <- gg_ye_co_sec +
    geom_point(alpha = .5) +
    scale_y_continuous(labels = function(x){paste0(x, " Mt CO2/yr")}) +
    labs(y = NULL, x = NULL,
         title = bquote(Annual~CO[2]~emissions~by~sectors)) +
    theme(
      panel.grid.major = element_line(colour = "grey90", size = 0.5),
      panel.background = element_blank(),
      panel.grid.minor = element_blank(),
      legend.key = element_blank(),
      legend.position = "top",
      legend.title = element_text(size = 14, color = "grey20"),
      legend.text = element_text(size = 12, color = "grey50"),
      plot.title = element_text(size = 22, margin = margin(b = 15)),
      plot.subtitle = element_text(size = 14, margin = margin(b = 15)),
      plot.caption = element_text(size = 14, color = "grey50", margin = margin(t = 25)),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      axis.text = element_text(size = 14),
      axis.line.x = element_line(color = "grey20"),
      axis.ticks.x = element_line(color = "grey20"),
      plot.margin = margin(20, 20, 10, 20)
      )

final_plot <- (gg_ye_co_th + gg_ye_co_sec_th) /
  (gg_ye_temp_th + gg_co_temp_th) +
  plot_annotation(
    title = expression(paste("Annual mean temperature and "~CO[2], " emissions relationship over the years in Alcalá de Henares, Madrid (1950-2020)")),
    caption = "   Data source:
      -Moreno A, Hasenauer H (2016). “Spatial downscaling of European climate data” International Journal of Climatology, 1444–1458.
      -Rammer W, Pucher C, Neumann M (2018). Description, Evaluation and Validation of Downscaled Daily Climate Data Version 2.
      -Cruz-Alonso V, Rodríguez-Sánchez F, Pucher C, Ratcliffe S, Astigarraga J, Neumann M, Ruiz-Benito P (2021). easyclimate: Easy access to high-resolution daily climate data for Europe.
      -Crippa M, Guizzardi D, Muntean M, Schaaf E, Solazzo E, Monforti-Ferrario F, Olivier JGJ, Vignati E, Fossil CO2 emissions of all world countries - 2020 Report, EUR 30358 EN,
       Publications Office of the European Union, Luxembourg, 2020.
    Graphic: PhD EBD seminar",
    theme = theme(
      plot.title = element_text(size = 24, face = "bold"),
      plot.caption = element_text(hjust = 0, size = 14, color = "grey50", margin = margin(t = 25))
      )
    )

ggsave(
  plot = final_plot,
  here("04-output", "sevilla_co2_temp.png"),
  width = 20, height = 14
)
```

3\. Useful

``` r
read_all_rds <- function(path){
  path %>%
    dir_ls(regexp = "\\.rds$") |> 
    map(readRDS)
}

rds_files <- read_all_rds(path = here("01-data"))
```

4\. Advanced exercise:

-   Fit a linear model for each sector
    `lm(Tmean.year ~ co_value, data = .x)` and store it as a list-column
-   Predict the response for the data stored in the `data` column using
    the corresponding linear model
-   Calculate the correlation between the predicted response and the
    true response
-   Run in parallel

``` r
co_temp_nested <- co_temp |>
  drop_na(Sector) |> 
  group_by(Sector) |>
  nest() |> 
  mutate(
    lm_obj = map(data, ~lm(
      Tmean.year ~ co_value, data = .x)),
    pred = map2(lm_obj, data,
                ~predict(.x, .y)),
    cor = map2_dbl(pred, data, ~cor(.x, .y$Tmean.year))
    )

co_temp_nested["pred"][[1]]
```

    ## [[1]]
    ##        1        2        3        4        5        6 
    ## 18.17497 18.31394 18.37289 18.25162 18.21119 18.29120 
    ##        7        8        9       10       11       12 
    ## 18.31141 18.39058 18.46975 18.65671 18.54386 18.50343 
    ##       13       14       15       16       17       18 
    ## 18.57502 18.60702 18.62639 18.68366 18.69377 18.69630 
    ##       19       20       21       22       23       24 
    ## 18.66935 18.51522 18.61460 18.81589 18.89674 18.84284 
    ##       25       26       27       28       29       30 
    ## 18.94980 18.94980 19.03992 19.04076 19.03739 19.20246 
    ##       31       32       33       34       35       36 
    ## 19.43912 19.46944 19.51744 19.73136 20.00003 20.03287 
    ##       37       38       39       40       41       42 
    ## 20.08762 19.90654 19.73894 19.67999 19.87959 19.63956 
    ##       43       44       45       46       47       48 
    ## 19.61851 19.59830 19.43828 19.62019 19.66988 19.79453 
    ##       49       50 
    ## 19.80850 19.98574 
    ## 
    ## [[2]]
    ##        1        2        3        4        5        6 
    ## 18.68744 18.73370 19.07153 18.98008 19.03764 19.08067 
    ##        7        8        9       10       11       12 
    ## 19.15168 19.10918 19.06131 19.14038 19.07744 19.15491 
    ##       13       14       15       16       17       18 
    ## 19.09304 19.09197 18.99353 18.93274 18.90638 18.91821 
    ##       19       20       21       22       23       24 
    ## 18.96986 19.03979 19.07529 19.07583 18.91068 18.86603 
    ##       25       26       27       28       29       30 
    ## 18.95748 19.03710 19.05646 19.13285 19.26626 19.32059 
    ##       31       32       33       34       35       36 
    ## 19.38783 19.31736 19.35986 19.45992 19.45239 19.49004 
    ##       37       38       39       40       41       42 
    ## 19.45938 19.47552 19.28939 18.96609 18.99621 18.95479 
    ##       43       44       45       46       47       48 
    ## 18.91714 18.78158 18.87841 18.88379 18.88755 18.89723 
    ##       49       50 
    ## 18.90567 18.91475 
    ## 
    ## [[3]]
    ##        1        2        3        4        5        6 
    ## 19.05971 19.08279 19.07958 19.06093 19.05544 19.06316 
    ##        7        8        9       10       11       12 
    ## 19.05488 19.05329 19.05942 19.06138 19.06563 19.07000 
    ##       13       14       15       16       17       18 
    ## 19.08385 19.08024 19.08770 19.08873 19.08852 19.09144 
    ##       19       20       21       22       23       24 
    ## 19.08043 19.08069 19.08189 19.07642 19.08221 19.08815 
    ##       25       26       27       28       29       30 
    ## 19.07812 19.07597 19.08350 19.06878 19.06995 19.07759 
    ##       31       32       33       34       35       36 
    ## 19.06207 19.05266 19.05515 19.04096 19.03894 19.03502 
    ##       37       38       39       40       41       42 
    ## 19.05422 19.04353 19.05449 19.07876 19.07239 19.07955 
    ##       43       44       45       46       47       48 
    ## 19.07825 19.08340 19.09085 19.09608 19.09602 19.08868 
    ##       49       50 
    ## 19.08954 19.08398 
    ## 
    ## [[4]]
    ##        1        2        3        4        5        6 
    ## 17.93639 17.95292 18.01403 18.10173 18.27211 18.41516 
    ##        7        8        9       10       11       12 
    ## 18.65119 18.45470 18.40941 18.49951 18.88651 19.09450 
    ##       13       14       15       16       17       18 
    ## 19.06407 19.09570 18.89753 18.76645 18.83115 18.81414 
    ##       19       20       21       22       23       24 
    ## 18.58266 18.96438 18.97253 18.98931 19.20976 18.97277 
    ##       25       26       27       28       29       30 
    ## 19.00728 19.22749 18.90831 19.20473 19.19442 19.62839 
    ##       31       32       33       34       35       36 
    ## 19.72807 19.56489 19.95116 19.77192 19.97129 20.18264 
    ##       37       38       39       40       41       42 
    ## 20.04006 20.23129 19.85388 19.48797 19.10720 19.46305 
    ##       43       44       45       46       47       48 
    ## 19.57423 19.04466 19.07509 19.34371 19.05017 19.31016 
    ##       49       50 
    ## 19.12105 18.71320 
    ## 
    ## [[5]]
    ##        1        2        3        4        5        6 
    ## 17.96791 18.02062 18.05919 18.18521 18.25014 18.27912 
    ##        7        8        9       10       11       12 
    ## 18.36394 18.35124 18.40466 18.53140 18.48996 18.42862 
    ##       13       14       15       16       17       18 
    ## 18.42551 18.43533 18.47462 18.46168 18.49594 18.55728 
    ##       19       20       21       22       23       24 
    ## 18.77362 18.85484 18.92312 18.98565 19.07094 19.04698 
    ##       25       26       27       28       29       30 
    ## 19.10208 19.13203 19.24871 19.24703 19.42576 19.52806 
    ##       31       32       33       34       35       36 
    ## 19.57358 19.67133 19.71205 19.83137 19.93606 20.02614 
    ##       37       38       39       40       41       42 
    ## 20.11862 20.19002 20.04124 19.83568 19.76596 19.61071 
    ##       43       44       45       46       47       48 
    ## 19.38934 19.36370 19.37185 19.45858 19.50865 19.53045 
    ##       49       50 
    ## 19.57188 19.57655

``` r
co_temp_nested |> 
  pluck("pred", 1)
```

    ##        1        2        3        4        5        6 
    ## 18.17497 18.31394 18.37289 18.25162 18.21119 18.29120 
    ##        7        8        9       10       11       12 
    ## 18.31141 18.39058 18.46975 18.65671 18.54386 18.50343 
    ##       13       14       15       16       17       18 
    ## 18.57502 18.60702 18.62639 18.68366 18.69377 18.69630 
    ##       19       20       21       22       23       24 
    ## 18.66935 18.51522 18.61460 18.81589 18.89674 18.84284 
    ##       25       26       27       28       29       30 
    ## 18.94980 18.94980 19.03992 19.04076 19.03739 19.20246 
    ##       31       32       33       34       35       36 
    ## 19.43912 19.46944 19.51744 19.73136 20.00003 20.03287 
    ##       37       38       39       40       41       42 
    ## 20.08762 19.90654 19.73894 19.67999 19.87959 19.63956 
    ##       43       44       45       46       47       48 
    ## 19.61851 19.59830 19.43828 19.62019 19.66988 19.79453 
    ##       49       50 
    ## 19.80850 19.98574

``` r
co_temp_nested

# parallel
plan(multisession, workers = 2)

co_temp_nested <- co_temp |>
  drop_na(Sector) |> 
  group_by(Sector) |>
  nest() |> 
  mutate(
    lm_obj = future_map(data, ~lm(
      Tmean.year ~ co_value, data = .x)),
    pred = future_map2(lm_obj, data,
                ~predict(.x, .y)),
    cor = future_map2_dbl(pred, data, ~cor(.x, .y$Tmean.year))
    )
```

``` r
render(input = here("03-scripts", "EBD", "intro_tidyverse.Rmd"),
       output_file = here("05-final_docs"),
       output_format = "github_document")
```

## Recommended reading

-   [R for Data Science](https://r4ds.had.co.nz/) by Hadley Wickham &
    Garrett Grolemund (the information in this document is based mainly
    on this book)

-   Wickham et al., (2019). Welcome to the Tidyverse. Journal of Open
    Source Software, 4(43), 1686, <https://doi.org/10.21105/joss.01686>

-   Core tidyverse packages:

    -   [readr](https://readr.tidyverse.org/): read rectangular data
    -   [tibble](https://tibble.tidyverse.org/): modern reimagining of
        the data.frame
    -   [tidyr](https://tidyr.tidyverse.org/): tidy data
    -   [dplyr](https://dplyr.tidyverse.org/): data manipulation
    -   [ggplot2](https://ggplot2.tidyverse.org/): data visualisation
    -   [stringr](https://stringr.tidyverse.org/): string manipulation
    -   [forcats](https://forcats.tidyverse.org/): solve problems with
        factors
    -   [purrr](https://purrr.tidyverse.org/): functional programming

------------------------------------------------------------------------

<details>
<summary>

Session Info

</summary>

``` r
Sys.time()
```

    ## [1] "2022-06-12 16:04:25 CEST"

``` r
git2r::repository()
```

    ## Local:    main C:/Users/julen/OneDrive - Universidad de Alcala/species-ranges/coding-support-group/intro_tidyverse
    ## Remote:   main @ origin (https://github.com/Julenasti/intro_tidyverse-dplyr.git)
    ## Head:     [c526068] 2022-06-11: first draft ebd seminar

``` r
sessionInfo()
```

    ## R version 4.2.0 (2022-04-22 ucrt)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 19044)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United Kingdom.utf8 
    ## [2] LC_CTYPE=English_United Kingdom.utf8   
    ## [3] LC_MONETARY=English_United Kingdom.utf8
    ## [4] LC_NUMERIC=C                           
    ## [5] LC_TIME=English_United Kingdom.utf8    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets 
    ## [6] methods   base     
    ## 
    ## other attached packages:
    ##  [1] rmarkdown_2.14    forcats_0.5.1     stringr_1.4.0    
    ##  [4] dplyr_1.0.9       purrr_0.3.4       readr_2.1.2      
    ##  [7] tidyr_1.2.0       tibble_3.1.7      tidyverse_1.3.1  
    ## [10] furrr_0.3.0       future_1.25.0     fs_1.5.2         
    ## [13] ggpmisc_0.4.6     ggpp_0.4.4        ggplot2_3.3.6    
    ## [16] viridis_0.6.2     viridisLite_0.4.0 patchwork_1.1.1  
    ## [19] easyclimate_0.1.6 here_1.0.1       
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] nlme_3.1-157       bit64_4.0.5       
    ##  [3] lubridate_1.8.0    httr_1.4.3        
    ##  [5] rprojroot_2.0.3    tools_4.2.0       
    ##  [7] backports_1.4.1    utf8_1.2.2        
    ##  [9] R6_2.5.1           mgcv_1.8-40       
    ## [11] DBI_1.1.2          colorspace_2.0-3  
    ## [13] withr_2.5.0        tidyselect_1.1.2  
    ## [15] gridExtra_2.3      prettyunits_1.1.1 
    ## [17] processx_3.5.3     bit_4.0.4         
    ## [19] curl_4.3.2         compiler_4.2.0    
    ## [21] git2r_0.30.1       cli_3.3.0         
    ## [23] rvest_1.0.2        quantreg_5.93     
    ## [25] SparseM_1.81       xml2_1.3.3        
    ## [27] labeling_0.4.2     scales_1.2.0      
    ## [29] callr_3.7.0        digest_0.6.29     
    ## [31] jpeg_0.1-9         pkgconfig_2.0.3   
    ## [33] htmltools_0.5.2    parallelly_1.31.1 
    ## [35] dbplyr_2.1.1       fastmap_1.1.0     
    ## [37] highr_0.9          maps_3.4.0        
    ## [39] rlang_1.0.2        readxl_1.4.0      
    ## [41] rstudioapi_0.13    generics_0.1.2    
    ## [43] farver_2.1.0       jsonlite_1.8.0    
    ## [45] vroom_1.5.7        magrittr_2.0.3    
    ## [47] Matrix_1.4-1       munsell_0.5.0     
    ## [49] fansi_1.0.3        lifecycle_1.0.1   
    ## [51] stringi_1.7.6      yaml_2.3.5        
    ## [53] MASS_7.3-56        pkgbuild_1.3.1    
    ## [55] grid_4.2.0         parallel_4.2.0    
    ## [57] listenv_0.8.0      crayon_1.5.1      
    ## [59] lattice_0.20-45    haven_2.5.0       
    ## [61] splines_4.2.0      hms_1.1.1         
    ## [63] knitr_1.39.3       ps_1.7.0          
    ## [65] pillar_1.7.0       emo_0.0.0.9000    
    ## [67] codetools_0.2-18   reprex_2.0.1      
    ## [69] glue_1.6.2         evaluate_0.15     
    ## [71] remotes_2.4.2      modelr_0.1.8      
    ## [73] vctrs_0.4.1        png_0.1-7         
    ## [75] tzdb_0.3.0         MatrixModels_0.5-0
    ## [77] cellranger_1.1.0   gtable_0.3.0      
    ## [79] assertthat_0.2.1   xfun_0.31         
    ## [81] broom_0.8.0        survival_3.3-1    
    ## [83] globals_0.15.0     ellipsis_0.3.2

</details>
