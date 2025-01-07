# [Christmas time zone madness](https://adventofsql.com/challenges/17)

## Description
Santa’s global operation spans multiple workshops, with the North Pole HQ coordinating a vast network of elves. From New York to London and further, each workshop plays a critical role in ensuring Christmas magic happens on time, managing everything from toy production to sleigh logistics. But there’s a challenge—time. Each location operates on 9 AM to 5 PM local hours, creating a complex puzzle of finding meeting windows when everyone can connect.

For the operation to run smoothly, aligning schedules is crucial. The elves need to pinpoint the rare moments when all workshops can virtually gather, sharing updates and solving problems without disrupting productivity. It’s a race against the clock to ensure the entire operation is synchronized for holiday delivery. Despite the challenge, the magic of teamwork keeps the North Pole’s mission stronger than ever.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-17/blob/main/advent_of_sql_day_17.sql)

+ Find all possible 60-minute meeting windows where all participating workshops are within their business hours
+ Return results in UTC format
+ Submit the earliest meeting start time that all offices can make

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM workshops ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-17/blob/main/workshops.PNG)


### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-17/blob/main/advent_answer_day17.sql)

**input**
```sql
WITH CTE AS (select
		    *,
		    ((timestamp '2024-12-17' + business_start_time)
		        at time zone timezone
		        at time zone 'utc') as utc_start,
		    ((timestamp '2024-12-17' + business_end_time)
		        at time zone timezone
		        at time zone 'utc') as utc_end
		from workshops)
SELECT CTE.timezone, MAX(CTE.utc_start) AS earliest_meeting_time
FROM CTE
GROUP BY CTE.timezone
ORDER BY earliest_meeting_time DESC ;

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-17/blob/main/d17.PNG)

