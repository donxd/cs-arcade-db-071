DROP FUNCTION IF EXISTS get_total;
CREATE FUNCTION get_total(items VARCHAR(45)) RETURNS INT DETERMINISTIC
BEGIN
    RETURN (SELECT SUM(price) FROM item_prices WHERE REGEXP_LIKE(items, CONCAT('(^',id,'(?![0-9]))|((?<=[^0-9])',id,'(?![0-9]))')) );
END;

CREATE PROCEDURE orderPrices()
BEGIN
    SELECT id, buyer, get_total(items) AS total_price
    FROM orders
    ORDER BY id;
END;
