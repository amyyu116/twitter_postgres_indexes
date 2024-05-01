/*
 * Count the number of English tweets containing the word "coronavirus"
 */


SELECT COUNT(distinct data ->> 'id')
FROM tweets_jsonb
WHERE
    to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))@@to_tsquery('english', 'coronavirus')
    AND data->>'lang' = 'en';
