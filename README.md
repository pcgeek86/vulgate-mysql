# vulgate-mysql

This repository contains the text of the [Vulgate](https://en.wikipedia.org/wiki/Vulgate) in a single MySQL file, for easy import. Data was taken from [this repository](https://github.com/LukeSmithxyz/vul) in tab-delimited format, and reformatted to a MySQL-compatible language, using a PowerShell script.

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

### Import with MySQL CLI (manually)

1. Run a MySQL container
2. Obtain an interactive shell in the container
3. Run the MySQL CLI
4. Copy / paste `vulgate.sql` into the terminal

```
docker run --name mysqlserver --detach --env MYSQL_ROOT_PASSWORD=trevor mysql:8.0.26
docker attach --interactive --tty mysqlserver bash
mysql --password=trevor
```

### Import with MySQL CLI

1. Run a MySQL container
2. Copy `vulgate.sql` into the container's filesystem
3. Run the MySQL CLI using `docker exec`

```
git clone https://github.com/pcgeek86/vulgate-mysql
docker run --name mysqlserver --detach --env MYSQL_ROOT_PASSWORD=trevor mysql:8.0.26
docker cp vulgate-mysql/vulgate.sql mysqlserver:/
docker exec --interactive --tty mysqlserver mysql --password=trevor --execute='source /vulgate.sql'
```

## Sample Queries

### Select All Genesis Verses

```
SELECT * FROM vulgate.vulgate_text WHERE BookName = 'Genesis';
```

### Select All Verses Mentioning Spiritu Sancto

```
SELECT * FROM vulgate.vulgate_text WHERE VerseText REGEXP 'Spiritu Sancto';
```

### List All Books in the Vulgate

```
SELECT DISTINCT BookName, BookNumber FROM vulgate.vulgate_text;
```

### Select All Verses Mentioning Patience in the New Testament

```
SELECT * FROM vulgate.vulgate_text WHERE BookNumber >= 42 AND VerseText REGEXP 'patientia';
```

### Find Out Which Book Has the Most Chapters

```
SELECT BookName, COUNT(DISTINCT Chapter) AS ChapterCount 
  FROM vulgate.vulgate_text
  GROUP BY BookName
  ORDER BY ChapterCount
  DESC;
```
