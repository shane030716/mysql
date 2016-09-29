CREATE DEFINER=`user`@`localhost` PROCEDURE `my_procedure`()
BEGIN
DECLARE column1 INT(11);
DECLARE column2 VARCHAR(100);
DECLARE column3 DATE;
DECLARE column4 TINYINT(1);

DECLARE bDone INT;
DECLARE curs CURSOR FOR SELECT * FROM my_table;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone = 1;

SET bDone = 0;

OPEN curs;
	read_loop: LOOP
		FETCH curs INTO column1, column2, column3, column4;
		IF bDone THEN
			LEAVE read_loop;
		END IF;

		-- Other statements

		SET bDone = 0;
	END LOOP read_loop;
CLOSE curs;
END	