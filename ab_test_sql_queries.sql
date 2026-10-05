
CREATE TABLE ab_test_users (
    user_id VARCHAR(20) PRIMARY KEY,
    experiment_group VARCHAR(20),
    date DATE,
    device VARCHAR(20),
    country VARCHAR(50),
    user_type VARCHAR(20),
    traffic_source VARCHAR(50),
    sessions INT,
    session_duration_sec DECIMAL(10,2),
    product_views INT,
    add_to_cart SMALLINT,
    checkout_started SMALLINT,
    purchased SMALLINT,
    order_value DECIMAL(10,2),
    revenue_per_user DECIMAL(10,2)
);

select * from ab_test_users;

SELECT COUNT(*) AS total_users
FROM ab_test_users;

SELECT
    COUNT(*) AS missing_session_duration
FROM ab_test_users
WHERE session_duration_sec IS NULL;

--SQL Query 1 — Control vs Treatment Conversion Rate
SELECT
    experiment_group,
    COUNT(*) AS total_users,
    SUM(purchased) AS purchases,
    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate
FROM ab_test_users
GROUP BY experiment_group
ORDER BY experiment_group;

--SQL Query 2 — Conversion Difference & Uplift
WITH conversion AS (
    SELECT
        experiment_group,
        SUM(purchased)::numeric / COUNT(*) AS conversion_rate
    FROM ab_test_users
    GROUP BY experiment_group
)
SELECT
    ROUND(
        MAX(CASE WHEN experiment_group = 'Control'
                 THEN conversion_rate END) * 100,
        2
    ) AS control_conversion,

    ROUND(
        MAX(CASE WHEN experiment_group = 'Treatment'
                 THEN conversion_rate END) * 100,
        2
    ) AS treatment_conversion,

    ROUND(
        (
            MAX(CASE WHEN experiment_group = 'Treatment'
                     THEN conversion_rate END)
            -
            MAX(CASE WHEN experiment_group = 'Control'
                     THEN conversion_rate END)
        ) * 100,
        2
    ) AS absolute_difference_pp,

    ROUND(
        (
            MAX(CASE WHEN experiment_group = 'Treatment'
                     THEN conversion_rate END)
            -
            MAX(CASE WHEN experiment_group = 'Control'
                     THEN conversion_rate END)
        )
        /
        MAX(CASE WHEN experiment_group = 'Control'
                 THEN conversion_rate END)
        * 100,
        2
    ) AS relative_uplift_percent
FROM conversion;


--3 AOV and Revenue/User

SELECT
    experiment_group,

    ROUND(
        SUM(order_value) / NULLIF(SUM(purchased), 0),
        2
    ) AS aov,

    ROUND(AVG(revenue_per_user), 2) AS revenue_per_user,

    ROUND(SUM(revenue_per_user), 2) AS total_revenue

FROM ab_test_users
GROUP BY experiment_group;


--sql 4 Complete checkout funnel
SELECT
    experiment_group,

    COUNT(*) AS users,

    SUM(add_to_cart) AS add_to_cart_users,

    SUM(checkout_started) AS checkout_users,

    SUM(purchased) AS purchase_users,

    ROUND(
        SUM(add_to_cart)::numeric / COUNT(*) * 100,2) AS add_to_cart_rate,

    ROUND(
        SUM(checkout_started)::numeric / COUNT(*) * 100,2) AS checkout_rate,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY experiment_group;


--5 Device analysis

SELECT
    device,
    experiment_group,
    COUNT(*) AS users,
    SUM(purchased) AS purchases,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY device, experiment_group
ORDER BY device, experiment_group;


--6 User-type analysis

SELECT
    user_type,
    experiment_group,
    COUNT(*) AS users,
    SUM(purchased) AS purchases,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY user_type, experiment_group
ORDER BY user_type, experiment_group;

--7 Country analysis
SELECT
    country,
    experiment_group,
    COUNT(*) AS users,
    SUM(purchased) AS purchases,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY country, experiment_group
ORDER BY country, experiment_group;


--8 Traffic-source analysis
SELECT
    traffic_source,
    experiment_group,
    COUNT(*) AS users,
    SUM(purchased) AS purchases,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY traffic_source, experiment_group
ORDER BY traffic_source, experiment_group;

--9 Date-wise conversion
SELECT
    date,
    experiment_group,
    COUNT(*) AS users,
    SUM(purchased) AS purchases,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY date, experiment_group
ORDER BY date, experiment_group;

--10 Session performance

SELECT
    experiment_group,

    ROUND(AVG(sessions), 2) AS avg_sessions,

    ROUND(AVG(session_duration_sec), 2) AS avg_session_duration,

    ROUND(AVG(product_views), 2) AS avg_product_views

FROM ab_test_users
GROUP BY experiment_group;

-- 11 Add-to-cart rate
SELECT
    experiment_group,

    ROUND(
        SUM(add_to_cart)::numeric / COUNT(*) * 100,2) AS add_to_cart_rate

FROM ab_test_users
GROUP BY experiment_group;


-- 12 Checkout rate
SELECT
    experiment_group,

    ROUND(
        SUM(checkout_started)::numeric / COUNT(*) * 100,2) AS checkout_rate

FROM ab_test_users
GROUP BY experiment_group;


--13 Purchase rate among checkout users


SELECT
    experiment_group,

    SUM(checkout_started) AS checkout_users,

    SUM(
        CASE
            WHEN checkout_started = 1
             AND purchased = 1
            THEN 1
            ELSE 0
        END
    ) AS completed_purchases,

    ROUND(
        SUM(
            CASE
                WHEN checkout_started = 1
                 AND purchased = 1
                THEN 1
                ELSE 0
            END
        )::numeric/ NULLIF(SUM(checkout_started), 0) * 100,2) AS checkout_to_purchase_rate

FROM ab_test_users
GROUP BY experiment_group;


-- 14 Guardrail metrics
SELECT
    experiment_group,

    ROUND(AVG(order_value), 2) AS avg_order_value,

    ROUND(AVG(revenue_per_user), 2) AS avg_revenue_per_user,

    ROUND(AVG(session_duration_sec), 2) AS avg_session_duration,

    ROUND(AVG(product_views), 2) AS avg_product_views

FROM ab_test_users
GROUP BY experiment_group;


-- 15 Find the best-performing device
SELECT
    device,
    experiment_group,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY device, experiment_group
ORDER BY conversion_rate DESC;


--16 Find the best-performing traffic source
SELECT
    traffic_source,
    experiment_group,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,2) AS conversion_rate

FROM ab_test_users
GROUP BY traffic_source, experiment_group
ORDER BY conversion_rate DESC;


--17 Find the best-performing country
SELECT
    country,
    experiment_group,

    ROUND(
        SUM(purchased)::numeric / COUNT(*) * 100,
        2
    ) AS conversion_rate

FROM ab_test_users
GROUP BY country, experiment_group
ORDER BY conversion_rate DESC;


-- 18 Executive SQL summary 


WITH metrics AS (
    SELECT
        experiment_group,
        COUNT(*) AS users,
        SUM(purchased) AS purchases,
        SUM(order_value) AS total_order_value,
        SUM(revenue_per_user) AS total_revenue
    FROM ab_test_users
    GROUP BY experiment_group
)
SELECT
    experiment_group,
    users,
    purchases,

    ROUND(
        purchases::numeric / users * 100,
        2
    ) AS conversion_rate,

    ROUND(
        total_order_value / NULLIF(purchases, 0),
        2
    ) AS aov,

    ROUND(
        total_revenue / users,
        2
    ) AS revenue_per_user

FROM metrics
ORDER BY experiment_group;