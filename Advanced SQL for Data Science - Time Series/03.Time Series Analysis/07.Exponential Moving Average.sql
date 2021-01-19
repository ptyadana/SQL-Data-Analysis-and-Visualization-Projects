/************ Exponential Moving Average **********/
/*
- A type of moving average
- wights decrease exponentially
- used to smooth trends when large variance in data


Smoothing Parameter
- typically 2 / (1+number of intervals)
- example, for 7 days of smoothing parameter is 0.25 (2/1+7)
- it is called lambda


Lambda Formula
- (current_period_value * lambda) + (previous_period_EWMA * (1-lambda))
- recursive
- could be calculated using Common Table Expression, but not recommended for large data sets.
- use User Defined function instead.

*/