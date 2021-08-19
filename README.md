# vulgate-mysql

This repository contains the text of the [Vulgate](https://en.wikipedia.org/wiki/Vulgate) in a single MySQL file, for easy import.

## Usage

In order to import this database into your MySQL server instance, use one of the following methods.

### Import with Adminer

1. Spin up a MySQL container and an Adminer container
2. Log into Adminer using [https://localhost:23455](https://localhost:23455)
3. Click on the SQL Command link
4. Copy / paste the file **or**
5. Use the import option to ingest the `vulgate.sql` file

```
docker run --detach --env MYSQL_ROOT_PASSWORD=seattle mysql:8.0.26
docker run --detach --publish 23455:8080 adminer:latest
```
