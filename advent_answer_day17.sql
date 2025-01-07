
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