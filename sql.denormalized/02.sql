SELECT tag, COUNT(DISTINCT id_tweets)
FROM (
	SELECT data->>'id' AS id_tweets,
		'#' || (jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text'::TEXT) as tag
        FROM tweets_jsonb
	WHERE
		data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]' OR
		data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
) t
GROUP BY tag
ORDER BY count DESC,tag
LIMIT 1000;
