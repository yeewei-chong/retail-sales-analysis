# Online Retail Sales Performance Analysis


### **Key Insights**

- Gross revenue stayed roughly the same even though there was a significant decrease in sales.
- Ireland still provided the highest value per customer, despite experiencing a decrease from the previous year.
- Australia has shown the biggest improvement in sales performance, providing 3 times the revenue, 2 times the average order value, and 6 times the average customer value compared to the previous year.
- Months near the start of the UK summer, the UK autumn, and the holiday season experienced an increase in sales, and a decrease in other months.
- The most popular product is the cream hanging heart T-light holder, with 1,777 units sold, followed closely by the 3-tier regency cakestand at 1,566 units sold.

This sales performance dashboard uses the Online Retail II dataset via UCI. The data was validated and loaded into customer, product, and invoice tables respectively in a PostgreSQL database, connected via foreign keys.

KPIs such as average order value and average customer value, as well as year-on-year change in revenue, were calculated dynamically via Power BI DAX. Since this dataset only covers two full years of data (2010 \& 2011), therefore I framed this as an annual sales report for the year 2011, comparing against 2010. Red in the visuals indicates a decrease from 2010, and green indicates an increase.

Clicking on the charts allows users to filter based on month, country, or product. For example, selecting Australia gives the KPIs specific to Australian customers, as shown below.

![alt text](images/sales_dashboard.png)

![alt text](images/sales_dashboard_aus.png)

