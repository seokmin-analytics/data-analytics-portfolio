SELECT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country
FROM retail_clean;

/*==============================
 * 03. cust_rfm 테이블 만들기
 * 
 *  cust_rfm.csv 만들어서 
 *  파이썬에서 분포 그룹짓기
 ================================*/


create table cust_rfm As
SELECT
    CustomerID,
    monetary,
    frequency,
    CASE when frequency = 1 then null
        else (julianday(last_date) - julianday(first_date))* 1.0  / (frequency-1) 
    END AS cycle,
    julianday('2011-12-10') - julianday(last_date) AS recency
FROM (
    SELECT
        CustomerID,
        SUM(Quantity * UnitPrice) AS monetary,
        COUNT(DISTINCT InvoiceNo) AS frequency,
        MIN(substr(InvoiceDate, 1, 10)) AS first_date,
        MAX(substr(InvoiceDate, 1, 10)) AS last_date
    FROM retail_clean
    GROUP BY CustomerID
);