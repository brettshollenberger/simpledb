# SimpleDB

### Running

```bash
bin/simple_db
```

SimpleDB reads from stdin and writes to stdout, so you can also pipe I/O.

```bash
bin/simple_db < input.txt
```

### Database Commands

* `SET` name value – Set the variable name to the value value. Neither variable names nor values will contain spaces.
* `GET` name – Print out the value of the variable name, or NULL if that variable is not set.
* `UNSET` name – Unset the variable name, making it just like that variable was never set.
* `NUMEQUALTO` value – Print out the number of variables that are currently set to value. If no variables equal that value, print 0.
* `END` – Exit the program.

### Transaction Commands

* `BEGIN` – Open a new transaction block. Transaction blocks can be nested; a BEGIN can be issued inside of an existing block.
* `ROLLBACK` – Undo all of the commands issued in the most recent transaction block, and close the block. Prints nothing if successful, or prints NO TRANSACTION if no transaction is in progress.
* `COMMIT` – Close all open transaction blocks, permanently applying the changes made in them. Prints nothing if successful, or prints NO TRANSACTION if no transaction is in progress.

### Performance

`GET`, `SET`, and `UNSET` all perform in `O(log n)` time, where n is the number of keys in the database.

`NUMEQUALTO` performs in `O(log n)` time, where n is the number of unique values in the database (generally minimally fewer than the number of keys).

All database actions achieve binary search tree balance through AVL Trees.
