/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
SELECT '#' || (jsonb->>'text'::TEXT) AS tag, COUNT(id_tweets)
FROM (
        SELECT data->>'id' AS id_tweets, data->>'lang' AS lang,
                jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            ) AS jsonb
        FROM tweets_jsonb
        WHERE
                data->>'lang' = 'en' AND (
		data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]' OR
                data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]')
) t
GROUP BY tag
ORDER BY count DESC,tag
LIMIT 1000;
