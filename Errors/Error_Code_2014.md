# Error Code: 2014. Commands out of sync; you can't run this command now

### Situation: 

Running a stored procedure.

For some reason, we got this error. Any following statements we ran returned this error no matter what.

Quitting the program (MySQLWOrkbench in my case) and restarting it resolved it temporarily, but as long as we ran the same stored procedure, we got the error again.

### Solution:

For my case, I used `LOOP` and `END LOOP` inside the stored procedure for the cursor, but I never tried to leave the loop. Adding the following right after the `FETCH` statement resolved it.
```
IF bDone THEN
	LEAVE read_loop;
END IF;
```

See more about [Loop and Cursor](https://github.com/shane030716/mysql/tree/master/Loop_and_Cursor#user-content-some-notes-about-using-loops-and-cursors-in-a-stored-procedure)
