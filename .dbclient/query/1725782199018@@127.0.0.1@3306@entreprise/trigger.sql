-- Active: 1725782199018@@127.0.0.1@3306@entreprise
CREATE TRIGGER TRG1 BEFORE INSERT ON commande FOR EACH ROW
BEGIN
   IF NEW.date_commande < CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La date de commande doit être égale ou supérieure à la date du jour';
   END IF;
END;

CREATE TRIGGER update_stock_on_delete
AFTER DELETE ON order_line
FOR EACH ROW
BEGIN
    -- Update the stock for the deleted product
    UPDATE product
    SET stock = stock + OLD.quantity
    WHERE product_id = OLD.product_id;

    -- Check if it is the last line for the order
    DECLARE order_line_count INT;
    SELECT COUNT(*) INTO order_line_count
    FROM order_line
    WHERE order_id = OLD.order_id;

    -- If no more lines exist, delete the order
    IF order_line_count = 0 THEN
        DELETE FROM commande WHERE order_id = OLD.order_id;
    END IF;
END;
