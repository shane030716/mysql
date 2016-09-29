# Some notes about using Loops and Cursors in a Stored Procedure

### Declare all variables that need to be fetched from the cursor
```
DECLARE column1 INT(11);
DECLARE column2 VARCHAR(100);
DECLARE column3 DATE;
DECLARE column4 TINYINT(1);
```

### Declare the `done` variable
```
DECLARE bDone INT;
```

### Declare the cursor for a select statement
```
DECLARE curs CURSOR FOR SELECT * FROM my_table;
```

### Declare the continue handler for 'not found', and when not found set bDone to 1
```
DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone = 1;
```

***

**Dynamic Statement for Cursor**

Note that if your select statement for the cursor is a dynamic statement. You might need to use a temporary table and add the following

```
DROP TABLE IF EXISTS my_temporary_table;

SET @sql = CONCAT('CREATE TEMPORARY TABLE my_temporary_table as SELECT * FROM ', table_name);
PREPARE stmt FROM @sql;
EXECUTE stmt;
```

And change the `my_table` above to `my_temporary_table`.
  
***

### Set not done
```
SET bDone = 0;
```

### Open and Close cursor
```
OPEN curs;
-- loop in here
Close
```

### Start looping

As far as I know, there are two ways to loop

```
read_loop: LOOP
-- fetch and other statements in here
END LOOP read_loop;
```
or
```
REPEAT
-- fetch and other statements in here
UNTIL bDone END REPEAT
```




