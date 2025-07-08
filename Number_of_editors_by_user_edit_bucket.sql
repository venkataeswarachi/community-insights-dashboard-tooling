-- Count number of actors in different contribution buckets
WITH revision_buckets AS (
    SELECT 
        CASE 
            WHEN COUNT(rev_id) = 0 THEN '0'
            WHEN COUNT(rev_id) BETWEEN 1 AND 5 THEN '1-5'
            WHEN COUNT(rev_id) BETWEEN 6 AND 99 THEN '6-99'
            WHEN COUNT(rev_id) BETWEEN 100 AND 999 THEN '100-999'
            WHEN COUNT(rev_id) BETWEEN 1000 AND 4999 THEN '1000-4999'
            ELSE '5000+'
        END AS bucket
    FROM revision
    GROUP BY rev_actor
) 
SELECT bucket, COUNT(*) AS number_of_editors
FROM revision_buckets
GROUP BY bucket
ORDER BY bucket;
