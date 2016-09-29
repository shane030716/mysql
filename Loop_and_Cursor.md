# Some notes about using Loops and Cursors in a Stored Procedure

#### Declare all variables that need to be fetched from the cursor
```
DECLARE column1 INT(11);
DECLARE column2 VARCHAR(100);
DECLARE column3 DATE;
DECLARE column4 TINYINT(1);
```

#### Declare the `done` variable
```
DECLARE bDone INT;
```

### Declare the cursor for a select statement
```
DECLARE curs CURSOR FOR SELECT * FROM my_table;
```

#### Declare the continue handler for 'not found', and when not found set bDone to 1
```
DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone = 1;
```

   #### Dynamic Statement for Cursor
   Note that if your select statement for the cursor is a dynamic statement. You might need to use a temporary table and add the following
  

