USE flipcart;

-- ============================================
-- SECTION A - THEORY
-- ============================================

-- A1. Answer: c
-- A2. Answer: b
-- A3. Answer: b
-- A4. Answer: c
-- A5. Answer: b
-- A6. Answer: c
-- A7. Answer: b
-- A8. Answer: c

-- ============================================
-- SECTION B - OUTPUT PREDICTION
-- ============================================

-- B1
-- Answer: 8
SELECT COUNT(*) AS total_electronics
FROM products
WHERE category = 'Electronics';

-- B2
-- Answer: 11 rows
SELECT *
FROM products
WHERE price BETWEEN 1000 AND 3000;

-- B3
-- Answer: The Silent Patient
SELECT product_name
FROM products
WHERE category = 'Books'
  AND price < 400
ORDER BY price DESC
LIMIT 1;

-- B4
-- Answer: 3 rows
SELECT *
FROM products
WHERE avg_rating IS NULL;

-- B5
-- Answer: ₹499.00
SELECT MAX(price) AS maximum_price
FROM products
WHERE category = 'Books';

-- B6
-- Answer:
-- Electronics | 7
-- Apparel     | 6
-- Home        | 5
SELECT category, COUNT(*) AS product_count
FROM products
WHERE is_active = TRUE
GROUP BY category
HAVING COUNT(*) > 4;

-- B7
-- Answer:
-- Nykaa Matte Lipstick        | Mid
-- Lakme Eye Liner             | Budget
-- Mamaearth Face Wash         | Budget
-- WOW Skin Vitamin C Serum    | Mid
SELECT product_name,
       CASE
           WHEN price < 500 THEN 'Budget'
           WHEN price < 5000 THEN 'Mid'
           ELSE 'Premium'
       END AS tier
FROM products
WHERE category = 'Beauty';

-- B8
-- Answer:
-- JBL Flip 6 Speaker          | 4.30
-- WOW Skin Vitamin C Serum    | 4.50
SELECT product_name,
       COALESCE(avg_rating, 0) AS rating
FROM products
WHERE stock_quantity = 0;

-- ============================================
-- SECTION C - APPLIED SQL
-- ============================================

-- C1 - Display all products with all columns
SELECT *
FROM products;

-- C2 - Product name and price of all Books
SELECT product_name, price
FROM products
WHERE category = 'Books';

-- C3 - Products priced above ₹10,000, highest to lowest
SELECT *
FROM products
WHERE price > 10000
ORDER BY price DESC;

-- C4 - Top 5 most expensive Electronics
SELECT product_name, price
FROM products
WHERE category = 'Electronics'
ORDER BY price DESC
LIMIT 5;

-- C5 - Products in Electronics or Apparel
SELECT *
FROM products
WHERE category IN ('Electronics', 'Apparel');

-- C6 - Products priced between ₹500 and ₹2,000
SELECT *
FROM products
WHERE price BETWEEN 500 AND 2000;

-- C7 - Product names containing 'Watch'
SELECT *
FROM products
WHERE product_name LIKE '%Watch%';

-- C8 - Brands starting with 'S'
SELECT *
FROM products
WHERE brand LIKE 'S%';

-- C9 - Unique categories
SELECT DISTINCT category
FROM products;

-- C10 - Total number of products
SELECT COUNT(*) AS total_products
FROM products;

-- C11 - Average price of Books
SELECT AVG(price) AS average_price
FROM products
WHERE category = 'Books';

-- C12 - Maximum and minimum price
SELECT MAX(price) AS maximum_price,
       MIN(price) AS minimum_price
FROM products;

-- C13 - Count products in each category
SELECT category,
       COUNT(*) AS product_count
FROM products
GROUP BY category;

-- C14 - Total stock quantity for each category
SELECT category,
       SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category;

-- C15 - Average price per category, highest to lowest
SELECT category,
       AVG(price) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;

-- C16 - Count and average price for brands
-- having more than 1 product
SELECT brand,
       COUNT(*) AS product_count,
       AVG(price) AS average_price
FROM products
GROUP BY brand
HAVING COUNT(*) > 1;

-- C17 - Categories with more than 4 active products
SELECT category,
       COUNT(*) AS active_products
FROM products
WHERE is_active = TRUE
GROUP BY category
HAVING COUNT(*) > 4;

-- C18 - 3 most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 3;

-- C19 - Categories where average price is above ₹2,000
SELECT category,
       AVG(price) AS average_price
FROM products
GROUP BY category
HAVING AVG(price) > 2000;

-- C20 - Products where rating is missing
SELECT *
FROM products
WHERE avg_rating IS NULL;

-- C21 - Display 'New Launch' when rating is NULL
SELECT product_name,
       CASE
           WHEN avg_rating IS NULL THEN 'New Launch'
           ELSE CAST(avg_rating AS CHAR)
       END AS rating
FROM products;

-- C22 - Classify products by price tier
SELECT product_name,
       price,
       CASE
           WHEN price < 1000 THEN 'Budget'
           WHEN price < 10000 THEN 'Mid'
           ELSE 'Premium'
       END AS price_tier
FROM products;

-- C23 - Total products and Premium products per category
SELECT category,
       COUNT(*) AS total_products,
       SUM(
           CASE
               WHEN price >= 10000 THEN 1
               ELSE 0
           END
       ) AS premium_products
FROM products
GROUP BY category;

-- C24 - Comprehensive category analysis
SELECT category,
       COUNT(*) AS total_products,
       SUM(
           CASE
               WHEN is_active = TRUE THEN 1
               ELSE 0
           END
       ) AS active_products,
       AVG(price) AS average_price,
       CASE
           WHEN AVG(price) < 1500 THEN 'Cheap'
           WHEN AVG(price) < 10000 THEN 'Standard'
           ELSE 'Luxury'
       END AS category_tier
FROM products
GROUP BY category
HAVING COUNT(*) >= 3
ORDER BY average_price DESC;