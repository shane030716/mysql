# Error code 1206: The number of locks exceeds the lock table size.

### Situation:

Copying a table with about 3.5 million rows of data to another. `INSERT INTO new_table SELECT * FROM old_table`

It takes really long, but eventually we got a **Error code 1206: The number of locks exceeds the lock table size.**
