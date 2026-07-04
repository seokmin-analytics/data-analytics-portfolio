SELECT event_time, event_type, product_id, category_id, category_code, brand, price, user_id, user_session
FROM onemonth;

/* =================================
 * 가설검증1 (user.csv 만들기)
 * 
 * user_id 별 
 * 카테고리 탐색개수와 구매의도 관계 분석
 * ================================= */

SELECT
    user_id,
   	count(distinct product_id) As product_cnt,
    COUNT(DISTINCT category_id) AS category_cnt,
    	max(case event_type when 'purchase' then 1
		else 0 END) As purchase_flag,
    COUNT(
        DISTINCT CASE
            WHEN event_type='purchase'
            THEN category_id
        END
    ) AS purchase_category_cnt
FROM onemonth
GROUP BY user_id;


/* =================================
 * 가설검증2 (user_category.csv 만들기)          가설검증3                        가설검증4-2
 * 
 * user_id, category_id 별 
 * category_cnt 그룹에 따른 rank top10          event_cnt 와 구매의사비율 관계      category_cnt 와 개별 상품에 대한 집중도의 관계    
 * ================================= */

SELECT
    user_id, category_id,
    count(DISTINCT product_id) As product_cnt,
	count(event_type ) AS event_cnt,
    max(case event_type when 'purchase' then 1
		else 0 END) As purchase_flag,
    COUNT(
        DISTINCT CASE
            WHEN event_type='purchase'
            THEN category_id
        END
    ) AS purchase_category_cnt
FROM onemonth
GROUP BY user_id, category_id;



/* ======================================
 * 가설검증 4-1 (user_concentration.csv 만들기)
 * 
 * user_id 별 
 * 상품집중도와 구매의사비율의 관계
 * ===================================== */

SELECT
    user_id,
    count(DISTINCT category_id) As category_cnt,
    count(DISTINCT product_id) As product_cnt,
	count(event_type ) AS event_cnt,
    max(case event_type when 'purchase' then 1
		else 0 END) As purchase_flag,
    COUNT(
        DISTINCT CASE
            WHEN event_type='purchase'
            THEN category_id
        END
    ) AS purchase_category_cnt
FROM onemonth
GROUP BY user_id;


