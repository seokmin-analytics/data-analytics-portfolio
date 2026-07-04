SELECT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country
FROM raw_Online_Retail;

/*==============================
 * 01. pre_procession 테이블 만들기
 * 
 *  데이터 전처리
 ================================*/

create table pre_processing as
select *
from raw_Online_Retail  
where unitprice <> 0
	and description <> ''
	and StockCode not glob 'm'
	and StockCode not glob 'M'
	and StockCode not glob 'B'
	and StockCode not glob 'PADS'
	and StockCode not glob 'D'
	and StockCode not glob 'CRUK'
	and StockCode not glob 'C2'
	and StockCode not glob 'POST'
	and StockCode not glob 'DOT'
	and StockCode not glob 'S'
	and stockcode not like 'gift%' 
	and stockcode not like 'BANK%'
	and stockcode not like 'AMAZON%'
	and Description not glob 'ebay'
	and customerid <> '';