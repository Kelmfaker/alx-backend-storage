DELIMITER //


CREATE TRIGGER decrease_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - number
    WHERE name = NEW.item_name;
END;
//

DELIMITER ;
