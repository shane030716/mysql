# Some notes about using Loops and Cursors in a Stored Procedure

### Declare all variables that need to be fetched from the cursor
```
DECLARE column1 INT(11);
DECLARE column2 VARCHAR(100);
DECLARE column3 DATE;
DECLARE column4 TINYINT(1);
```

*Note use different names of the variable you are declaring from the names of the columns of the table you are fetching*

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

### Fetching
Fetch the current row of values from the cursor to the variables we declared above. The numbers of columns must match.
```
FETCH curs INTO column_1, column_2, column_3, column_4;
```

### Leaving the loop
Initally you might think, when the cursor reaches the end and there's nothing to fetch, it just leave the loop. This is not necessarily true, and there are some treaks that needs to be done.
For the first looping method, we need to add the following right below the fetch statement.
```
IF bDone THEN
  LEAVE read_loop;
END IF;
```
If not, you will be in an infinity loop, and you will probably get this error **Error Code: 2014 - Commands out of sync; you can't run this command now**
```
read_loop: LOOP
  FETCH curs INTO column1, column2, column3, column4;
  IF bDone THEN
    LEAVE read_loop;
  END IF;
  
  -- Other statements
END LOOP read_loop;
```

For the second looping 



