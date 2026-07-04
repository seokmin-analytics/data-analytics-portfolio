SELECT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country
FROM pre_processing;

/*==============================
 * 02. retail_clean 테이블 만들기
 * 
 *  구매보다 반품이 많은 데이터 제거
 ================================*/

CREATE TABLE retail_clean AS
WITH tmp AS (
    SELECT
        CustomerID,
        StockCode,
        SUM(CASE WHEN Quantity > 0 THEN Quantity ELSE 0 END) AS pch_qty,
        SUM(CASE WHEN Quantity < 0 THEN -Quantity ELSE 0 END) AS rf_qty
    FROM pre_processing
    GROUP BY
        CustomerID,
        StockCode
)
SELECT p.*
FROM pre_processing p
JOIN tmp t
    ON p.CustomerID = t.CustomerID
   AND p.StockCode = t.StockCode
WHERE t.pch_qty - t.rf_qty > 0;