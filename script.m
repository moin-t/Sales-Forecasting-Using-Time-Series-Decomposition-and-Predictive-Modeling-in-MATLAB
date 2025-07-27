%1. Vectorization:

sales = monthlysales.Sales_Rands;
months = 1:length(sales);

%2. Semi_Avg Trendline:

n = length(sales);
first_half = sales(1:floor(n/2));
second_half = sales(floor(n/2)+1:end);
semi_avg1 = mean(first_half);
semi_avg2 = mean(second_half);
trend = [repmat(semi_avg1, 1, floor(n/2)), repmat(semi_avg2, 1, ceil(n/2))];
figure;
plot(months, sales, 'bo-', 'LineWidth', 1.5); hold on;
plot(months, trend, 'r--', 'LineWidth', 2);
title('Semi-Average Trend Line'); xlabel('Month'); ylabel('Sales (Rands)');
legend('Actual Sales', 'Semi-Average'); grid on;

%3. Least Square Trendlline:

p = polyfit(months, sales, 1);
fitted_line = polyval(p, months);
figure;
plot(months, sales, 'bo'); hold on;
plot(months, fitted_line, 'r-', 'LineWidth', 2);
title('Least Squares Trend Line'); xlabel('Month'); ylabel('Sales (Rands)');
legend('Actual Sales', 'Trend Line'); grid on;

%4. Ratio to Moving Average:

moving_avg = movmean(sales, [5 6], 'Endpoints', 'discard');
seasonal_ratios = sales(6:end-6) ./ moving_avg;
months_trimmed = months(6:end-6);
figure;
plot(months_trimmed, seasonal_ratios, 'ko-');
title('Ratio-to-Moving Average'); xlabel('Month'); ylabel('Seasonal Index'); grid on;

%5. 3-Month Centered Moving Avg:

smoothed_sales = movmean(sales, 3);
figure;
plot(months, sales, 'b.-'); hold on;
plot(months, smoothed_sales, 'r-', 'LineWidth', 2);
title('3-Month Centered Moving Average'); xlabel('Month'); ylabel('Sales (Rands)');
legend('Original Data', 'Smoothed Data'); grid on;

%6. Forecasting:

future_months = length(sales)+1:length(sales)+6;
future_forecast = polyval(p, future_months);
figure;
plot(months, sales, 'bo-'); hold on;
plot(months, fitted_line, 'g--', 'LineWidth', 2);
plot(future_months, future_forecast, 'r*-', 'LineWidth', 2);
title('Sales Forecast for Next 6 Months'); xlabel('Month'); ylabel('Sales (Rands)');
legend('Actual Sales', 'Trend Line', 'Forecast'); grid on;

%7. Residual Plot:

sales = monthlysales.Sales_Rands;
months = (1:length(sales))';  % Force column vector
p = polyfit(months, sales, 1);
predicted = polyval(p, months);
residuals = sales - predicted;
months = months(:);       
residuals = residuals(:); 
figure;
scatter(months, residuals, 60, 'b', 'filled');  % blue dots
yline(0, 'k--', 'LineWidth', 1.2);              % baseline
xlabel('Month');
ylabel('Residuals (Actual - Predicted)');
title('Residual Scatter Plot of Sales Data');
grid on;
