# Error Code: 2013. Lost connection to MySQL server during query

Situation: 

running a query on MySQLWorkbench. 

The query takes a little long and eventually we got a **Error Code: 2013. Lost connection to MySQL server during query**. 

Checked the Duration / Fetch Time, it's always 600 seconds (10 minutes).

Reconnect database and `SHOW PROCESSLIST`, the query is still running.

Solution:

* Click MySQLWorkbench from top bar menu
* Click Preferences
* Select SQL Editor on the left
* Change DBMS connection read time out (in seconds) to something bigger, eg 6000. (Default is 600)
* Quit and restart MySQLWorkbench

More details of the settings in [here](https://dev.mysql.com/doc/workbench/en/wb-preferences-sql-editor.html)
