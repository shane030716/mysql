# Some notes about using Loops and Cursors in a Stored Procedure

tl;dr See examples [here](#overall-structures)

### Declare all variables that need to be fetched from the cursor
```
DECLARE column1 INT(11);
DECLARE column2 VARCHAR(100);
DECLARE column3 DATE;
DECLARE column4 TINYINT(1);
```

*Note use different names of the variable you are declaring from the names of the columns of the table you are fetching*

### Declare variables for "done", the cursor and the handler
```
DECLARE bDone INT;
DECLARE curs CURSOR FOR SELECT * FROM my_table;
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
UNTIL bDone END REPEAT;
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
If not, you will be in an infinity loop, and you will probably get this error **Error Code: 2014 - Commands out of sync; you can't run this command now**.

The whole loop will look like:
```
read_loop: LOOP
  FETCH curs INTO column1, column2, column3, column4;
  IF bDone THEN
    LEAVE read_loop;
  END IF;
  
  -- Other statements
END LOOP read_loop;
```

For the second looping, we need to the following around all other statements below the `FETCH` statement
```
IF NOT bDONE THEN
  -- OTHER statements
END IF;
```

If not, the last row of data from the cursor will be handled twice in "OTHER statements" because after finishing fetching all the from the cursor, bDone is still 0. So there will be one final empty fetch, which nothing really happend to the variables we declared. They are still the same as from the last iteration and they will be handled one more time in "Other statements"

The whole loop for the second method will look like:
```
REPEAT
  FETCH curs INTO column1, column2, column3, column4;
  IF NOT bDONE THEN
    -- Other statements
  END IF;
UNTIL bDONE END REPEAT;
```

### Be careful that the loop might exit prematurely
If in your "Other statements", one statement returns no result, this might set the bDone to 1 and it will exit the loop on the next iteration.

Therefore, we need to set bDone to 0 at the end of the loop every time, since the * **real** * moment for the dDone to be 1 is when the fetch fetches no results. So,

Full loop for the first method:
```
read_loop: LOOP
  FETCH curs INTO column1, column2, column3, column4;
  IF bDone THEN
    LEAVE read_loop;
  END IF;
  
  -- Other statements
  
  SET bDone = 0;
END LOOP read_loop;
```

And the whole loop for the second method:
```
REPEAT
  FETCH curs INTO column1, column2, column3, column4;
  IF NOT bDONE THEN
    -- Other statements
    
    SET bDONE = 0;
  END IF;
UNTIL bDONE END REPEAT;
```

### Overall Structures
See the 3 examples of the overall structure for using CURSORs:

1. [Static statement for the cursor and using `LOOP`](cursor1.sql)
2. [Static statement for the cursor and using 'REPEAT'](cursor2.sql)
3. [Dynamic statement for the cursor](cursor3.sql)


