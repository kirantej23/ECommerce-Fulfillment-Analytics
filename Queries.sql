PS C:\Users\kiran> mysql -u root -p;
Enter password: *************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 8.0.40 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+---------------------+
| Database            |
+---------------------+
| bhavana             |
| bhavs               |
| ecommerce_analytics |
| information_schema  |
| kirandatab1         |
| kirandb1            |
| mysql               |
| performance_schema  |
| sys                 |
+---------------------+
9 rows in set (0.02 sec)

mysql> use ecommerce_analytics;
Database changed

mysql> show tables;
+-------------------------------+
| Tables_in_ecommerce_analytics |
+-------------------------------+
| orders                        |
+-------------------------------+
1 row in set (0.00 sec)

select * from orders limit 10;
+-----------+-------------+------------+--------------------+-----------+------------------+-------------+-----------------+-----------------+---------------+---------------+------------------+
| order_id  | customer_id | order_date | fulfillment_status | ship_mode | product_category | order_value | delivery_region | customer_rating | delivery_days | delivery_date | on_time_delivery |
+-----------+-------------+------------+--------------------+-----------+------------------+-------------+-----------------+-----------------+---------------+---------------+------------------+
| ORD000001 | CUST5418    | 2026-06-27 | Delivered          | Standard  | Beauty           |       68.91 | Central         |               5 |             5 | 2026-07-02    |                1 |
| ORD000002 | CUST8897    | 2025-10-27 | Delivered          | Standard  | Toys             |      135.38 | Central         |               3 |             3 | 2025-10-30    |                1 |
| ORD000003 | CUST5690    | 2026-04-22 | Cancelled          | Standard  | Home Decor       |      252.89 | South           |               1 |             7 | 2026-04-29    |                0 |
| ORD000004 | CUST8368    | 2025-08-22 | Delivered          | Standard  | Toys             |      216.55 | North           |               2 |             8 | 2025-08-30    |                0 |
| ORD000005 | CUST1793    | 2026-04-23 | Delivered          | Express   | Clothing         |      375.19 | East            |               2 |             1 | 2026-04-24    |                1 |
| ORD000006 | CUST3096    | 2025-10-29 | Delivered          | Standard  | Electronics      |       28.83 | South           |               5 |             6 | 2025-11-04    |                0 |
| ORD000007 | CUST1570    | 2025-11-18 | Delivered          | Express   | Beauty           |      303.24 | West            |               5 |             1 | 2025-11-19    |                1 |
| ORD000008 | CUST1596    | 2026-04-25 | Delivered          | Express   | Home Decor       |      101.41 | North           |               5 |             2 | 2026-04-27    |                1 |
| ORD000009 | CUST6625    | 2025-12-21 | Delivered          | Standard  | Electronics      |      190.58 | South           |               5 |             7 | 2025-12-28    |                0 |
| ORD000010 | CUST3073    | 2026-06-09 | Delivered          | Standard  | Electronics      |      482.58 | North           |               1 |            10 | 2026-06-19    |                0 |
+-----------+-------------+------------+--------------------+-----------+------------------+-------------+-----------------+-----------------+---------------+---------------+------------------+
10 rows in set (0.00 sec)

mysql> describe orders;
+--------------------+--------+------+-----+---------+-------+
| Field              | Type   | Null | Key | Default | Extra |
+--------------------+--------+------+-----+---------+-------+
| order_id           | text   | YES  |     | NULL    |       |
| customer_id        | text   | YES  |     | NULL    |       |
| order_date         | text   | YES  |     | NULL    |       |
| fulfillment_status | text   | YES  |     | NULL    |       |
| ship_mode          | text   | YES  |     | NULL    |       |
| product_category   | text   | YES  |     | NULL    |       |
| order_value        | double | YES  |     | NULL    |       |
| delivery_region    | text   | YES  |     | NULL    |       |
| customer_rating    | int    | YES  |     | NULL    |       |
| delivery_days      | int    | YES  |     | NULL    |       |
| delivery_date      | text   | YES  |     | NULL    |       |
| on_time_delivery   | int    | YES  |     | NULL    |       |
+--------------------+--------+------+-----+---------+-------+
12 rows in set (0.01 sec)

mysql> show columns from orders;
+--------------------+--------+------+-----+---------+-------+
| Field              | Type   | Null | Key | Default | Extra |
+--------------------+--------+------+-----+---------+-------+
| order_id           | text   | YES  |     | NULL    |       |
| customer_id        | text   | YES  |     | NULL    |       |
| order_date         | text   | YES  |     | NULL    |       |
| fulfillment_status | text   | YES  |     | NULL    |       |
| ship_mode          | text   | YES  |     | NULL    |       |
| product_category   | text   | YES  |     | NULL    |       |
| order_value        | double | YES  |     | NULL    |       |
| delivery_region    | text   | YES  |     | NULL    |       |
| customer_rating    | int    | YES  |     | NULL    |       |
| delivery_days      | int    | YES  |     | NULL    |       |
| delivery_date      | text   | YES  |     | NULL    |       |
| on_time_delivery   | int    | YES  |     | NULL    |       |
+--------------------+--------+------+-----+---------+-------+
12 rows in set (0.01 sec)

mysql> select delivery_region,
    -> count(order_id) as total_orders,
    -> sum(on_time_delivery) as on_time_orders,
    -> round((sum(on_time_delivery)/count(order_id)) * 100,2) as otdr_percentage
    -> from orders
    -> group by delivery_region
    -> order by otdr_percentage ASC;
+-----------------+--------------+----------------+-----------------+
| delivery_region | total_orders | on_time_orders | otdr_percentage |
+-----------------+--------------+----------------+-----------------+
| North           |        19904 |           5878 |           29.53 |
| East            |        20274 |          14515 |           71.59 |
| South           |        20012 |          14409 |           72.00 |
| Central         |        19882 |          14335 |           72.10 |
| West            |        19928 |          14444 |           72.48 |
+-----------------+--------------+----------------+-----------------+
5 rows in set (0.85 sec)

mysql>
mysql> select
    -> customer_rating,
    -> avg(delivery_days) as avg_fulfillment_time_days,
    -> count(order_id) as total_orders
    -> from orders
    -> group by customer_rating
    -> order by customer_rating desc;
+-----------------+---------------------------+--------------+
| customer_rating | avg_fulfillment_time_days | total_orders |
+-----------------+---------------------------+--------------+
|               5 |                    4.6614 |        40104 |
|               4 |                    4.6603 |        34854 |
|               3 |                    4.6330 |        11922 |
|               2 |                    4.6420 |         8002 |
|               1 |                    4.6489 |         5118 |
+-----------------+---------------------------+--------------+
5 rows in set (0.18 sec)
mysql> SELECT
    ->     product_category,
    ->     COUNT(fulfillment_status) as total_cancellations,
    ->     ROUND(AVG(order_value), 2) as avg_cancelled_value
    -> FROM orders
    -> WHERE fulfillment_status = 'Cancelled'
    -> GROUP BY product_category
    -> ORDER BY total_cancellations DESC;
+------------------+---------------------+---------------------+
| product_category | total_cancellations | avg_cancelled_value |
+------------------+---------------------+---------------------+
| Clothing         |                1059 |               250.4 |
| Beauty           |                1019 |              248.79 |
| Home Decor       |                1012 |              254.65 |
| Toys             |                 995 |              252.14 |
| Electronics      |                 989 |              258.36 |
+------------------+---------------------+---------------------+
5 rows in set (0.16 sec)
mysql> select product_category,
    -> count(fulfillment_status) as total_cancelled,
    -> round(avg(order_value),2) as avg_canclled_value
    -> from orders
    -> where fulfillment_status = 'Cancelled'
    -> group by product_category
    -> order by total_cancelled;
+------------------+-----------------+--------------------+
| product_category | total_cancelled | avg_canclled_value |
+------------------+-----------------+--------------------+
| Electronics      |             989 |             258.36 |
| Toys             |             995 |             252.14 |
| Home Decor       |            1012 |             254.65 |
| Beauty           |            1019 |             248.79 |
| Clothing         |            1059 |              250.4 |
+------------------+-----------------+--------------------+
5 rows in set (0.10 sec)
mysql> SELECT
    ->     product_category,
    ->     COUNT(fulfillment_status) as total_cancellations,
    ->     ROUND(AVG(order_value), 2) as avg_cancelled_value
    -> FROM orders
    -> WHERE fulfillment_status = 'Cancelled'
    -> GROUP BY product_category
    -> ORDER BY total_cancellations DESC;
+------------------+---------------------+---------------------+
| product_category | total_cancellations | avg_cancelled_value |
+------------------+---------------------+---------------------+
| Clothing         |                1059 |               250.4 |
| Beauty           |                1019 |              248.79 |
| Home Decor       |                1012 |              254.65 |
| Toys             |                 995 |              252.14 |
| Electronics      |                 989 |              258.36 |
+------------------+---------------------+---------------------+
5 rows in set (0.08 sec)

mysql> describe orders;
+--------------------+--------+------+-----+---------+-------+
| Field              | Type   | Null | Key | Default | Extra |
+--------------------+--------+------+-----+---------+-------+
| order_id           | text   | YES  |     | NULL    |       |
| customer_id        | text   | YES  |     | NULL    |       |
| order_date         | text   | YES  |     | NULL    |       |
| fulfillment_status | text   | YES  |     | NULL    |       |
| ship_mode          | text   | YES  |     | NULL    |       |
| product_category   | text   | YES  |     | NULL    |       |
| order_value        | double | YES  |     | NULL    |       |
| delivery_region    | text   | YES  |     | NULL    |       |
| customer_rating    | int    | YES  |     | NULL    |       |
| delivery_days      | int    | YES  |     | NULL    |       |
| delivery_date      | text   | YES  |     | NULL    |       |
| on_time_delivery   | int    | YES  |     | NULL    |       |
+--------------------+--------+------+-----+---------+-------+
12 rows in set (0.05 sec)

mysql> select ship_mode,
    -> round(avg(order_value),2) as total_value
    -> from orders
    -> group by ship_mode;
+-----------+-------------+
| ship_mode | total_value |
+-----------+-------------+
| Standard  |      254.64 |
| Express   |      257.45 |
| Same Day  |      254.61 |
+-----------+-------------+
3 rows in set (0.16 sec)

mysql> select
    -> product_category,
    -> avg(customer_rating) as avg_rating
    -> from orders
    -> group by product_category;
+------------------+------------+
| product_category | avg_rating |
+------------------+------------+
| Beauty           |     3.9712 |
| Toys             |     3.9733 |
| Home Decor       |     3.9559 |
| Clothing         |     3.9666 |
| Electronics      |     3.9744 |
+------------------+------------+
5 rows in set (0.38 sec)

mysql> SELECT product_category,
    -> round(avg(customer_rating),2) as avg_rating
    -> from orders
    -> group by product_category
    -> order by avg_rating;
+------------------+------------+
| product_category | avg_rating |
+------------------+------------+
| Home Decor       |       3.96 |
| Beauty           |       3.97 |
| Toys             |       3.97 |
| Clothing         |       3.97 |
| Electronics      |       3.97 |
+------------------+------------+
5 rows in set (0.36 sec)

mysql> select product_category,
    -> count(order_id) as total_orders,
    -> round(avg(order_value),2) as avg_value
    -> from orders
    -> group by product_category
    -> having avg_value>200
    -> order by total_orders desc;
+------------------+--------------+-----------+
| product_category | total_orders | avg_value |
+------------------+--------------+-----------+
| Home Decor       |        20196 |    254.89 |
| Beauty           |        20120 |    255.47 |
| Toys             |        20038 |     256.3 |
| Clothing         |        19895 |     253.2 |
| Electronics      |        19751 |    256.13 |
+------------------+--------------+-----------+
5 rows in set (0.44 sec)

mysql> SELECT product_category, COUNT(order_id), ROUND(AVG(order_value), 2)
    -> FROM orders
    -> WHERE order_value > 200  -- Filters raw data first!
    -> GROUP BY product_category;
+------------------+-----------------+----------------------------+
| product_category | COUNT(order_id) | ROUND(AVG(order_value), 2) |
+------------------+-----------------+----------------------------+
| Home Decor       |           12332 |                     350.63 |
| Toys             |           12335 |                     350.69 |
| Clothing         |           12023 |                     350.61 |
| Beauty           |           12263 |                     351.32 |
| Electronics      |           12163 |                     349.86 |
+------------------+-----------------+----------------------------+
5 rows in set (0.31 sec)

mysql> select ship_mode,
    -> round(avg(delivery_days),1) as avg_days
    -> from orders
    -> where delivery_region='North'
    -> group by ship_mode
    -> having avg_days>5;
+-----------+----------+
| ship_mode | avg_days |
+-----------+----------+
| Standard  |     11.0 |
+-----------+----------+
1 row in set (0.26 sec)

mysql> SELECT ship_mode,
    ->        ROUND(AVG(delivery_days),1) as avg_days
    -> FROM orders
    -> WHERE delivery_region = 'North'
    -> GROUP BY ship_mode
    -> HAVING avg_days > 5;
+-----------+----------+
| ship_mode | avg_days |
+-----------+----------+
| Standard  |     11.0 |
+-----------+----------+
1 row in set (0.19 sec)

mysql> describe orders;
+--------------------+--------+------+-----+---------+-------+
| Field              | Type   | Null | Key | Default | Extra |
+--------------------+--------+------+-----+---------+-------+
| order_id           | text   | YES  |     | NULL    |       |
| customer_id        | text   | YES  |     | NULL    |       |
| order_date         | text   | YES  |     | NULL    |       |
| fulfillment_status | text   | YES  |     | NULL    |       |
| ship_mode          | text   | YES  |     | NULL    |       |
| product_category   | text   | YES  |     | NULL    |       |
| order_value        | double | YES  |     | NULL    |       |
| delivery_region    | text   | YES  |     | NULL    |       |
| customer_rating    | int    | YES  |     | NULL    |       |
| delivery_days      | int    | YES  |     | NULL    |       |
| delivery_date      | text   | YES  |     | NULL    |       |
| on_time_delivery   | int    | YES  |     | NULL    |       |
+--------------------+--------+------+-----+---------+-------+
12 rows in set (0.19 sec)

mysql>mysql> select fulfillment_status,
    -> count(*) as total_countus
    -> from orders
    -> where fulfillment_status='Delivered'
    -> group by fulfillment_status;
+--------------------+---------------+
| fulfillment_status | total_countus |
+--------------------+---------------+
| Delivered          |         79846 |
+--------------------+---------------+
1 row in set (0.39 sec)

mysql> select fulfillment_status,
    -> count(*) as total_count
    -> from orders
    -> where fulfillment_status='Delivered'
    -> group by fulfillment_status;
+--------------------+-------------+
| fulfillment_status | total_count |
+--------------------+-------------+
| Delivered          |       79846 |
+--------------------+-------------+
1 row in set (0.18 sec)

mysql> select fulfillment_status,
    -> count(*) as total_count
    -> from orders
    -> where fulfillment_status='Cancelled'
    -> group by fulfillment_status;
+--------------------+-------------+
| fulfillment_status | total_count |
+--------------------+-------------+
| Cancelled          |        5074 |
+--------------------+-------------+
1 row in set (0.13 sec)

mysql> SELECT DISTINCT fulfillment_status FROM orders;
+--------------------+
| fulfillment_status |
+--------------------+
| Delivered          |
| Cancelled          |
| Shipped            |
| Processing         |
+--------------------+
4 rows in set (0.27 sec)