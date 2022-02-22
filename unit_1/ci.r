ci = read.csv("data/cis.csv")

# already done - corrected confidence intervals!
# ci$lower_t = ci$mean + qt(0.025, 24)
# ci$upper_t = ci$mean + qt(0.975, 24)

pop = read.csv("data/w1t1.csv")
pop_mean = mean(pop$x)

# what proportion of times is the true mean within the 2 different CIs?
sum(pop_mean > ci$lower_t & pop_mean < ci$upper_t) / nrow(ci)
sum(pop_mean > ci$lower & pop_mean < ci$upper) / nrow(ci)


