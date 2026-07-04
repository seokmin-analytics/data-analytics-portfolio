SELECT event_time, event_type, product_id, category_id, category_code, brand, price, user_id, user_session
FROM "2019_Nov";

/* ================================= (코드 시험용)
 * oneweek table 만들기 
 * 
 * 전처리 11/1 ~11/7
 *       price > 0
 *       user_session not null
 * =================================*/

create table oneweek as
select *
from "2019_Nov"
where price > 0
 and user_session is not NULL
 and event_time >= '2019-11-01'
 and event_time < '2019-11-08'
 and user_session <> '';


/* =================================
 * onemonth table 만들기 
 * 
 * 전처리  price > 0
 *       user_session not null
 *  =================================*/

create table onemonth as
select *
from "2019_Nov"
where price > 0
 and user_session is not NULL
 and user_session <> '';