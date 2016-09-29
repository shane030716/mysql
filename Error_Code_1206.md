# Error code 1206: The number of locks exceeds the lock table size.

### Situation:

Copying a table with about 3.5 million rows of data to another. `INSERT INTO new_table SELECT * FROM old_table`. 

It takes really long, but eventually we got a **Error code 1206: The number of locks exceeds the lock table size.**

Googled and found this [post](http://stackoverflow.com/questions/6901108/the-total-number-of-locks-exceeds-the-lock-table-size)

### Solution:

* Login to Server, as root or super user
* Locate my.cnt, `locate my.cng`. Usually it's `/etc/my.cnf`
* Open the file and add this line `innodb_buffer_pool_size=64MB`
* Save and quit
* Restart mysql `/etc/init.d/mysqld restart`. Make sure no active transactions are happening

