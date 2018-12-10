library(feed)

tibble(name = "alfalfa", dm = 90, om = 90, cp = 25, ndf = 40, adf = 15)

feed_search("Timothy grass")
feed_list("forage")

timothy_grass <- feed_info("https://www.feedipedia.org/node/16886", extract = 4)
maize_grain <- feed_info(url="https://www.feedipedia.org/node/556",extract = 2)

timothy_grass[[1]]$`Main analysis`

df <- data.frame(matrix(ncol = 9, nrow = 1))
names(df) <- timothy_grass[[1]]$`Main analysis`

df[1,] <- timothy_grass[[1]]$Avg
df[2,] <- maize_grain[[1]]$Avg
df <- df[,-9]

df <- lapply(df[1:8], FUN = function(x) {as.numeric(x)}) %>% as.data.frame()
df <- df %>% mutate(Name = c("Timothy hay", "Corn grain"))
df$formula <- c(40, 60)

df
df1 <- lapply(df[1:8], function(x) x * (df$formula/100)) %>% as.data.frame()
df2 <- lapply(df1, sum) %>% as.data.frame()

df1 <- df1 %>% mutate(Name = c("Timothy hay", "Corn grain"))
df2 <- df2 %>% mutate(Name = c("Total"))

result <- list(each = df1, sum = df2)

result
