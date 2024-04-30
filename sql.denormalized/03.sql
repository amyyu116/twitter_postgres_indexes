SELECT lang, count(DISTINCT id) AS count
FROM (
    SELECT
        data->>'lang' as lang,
        data->>'id' as id
    FROM tweets_jsonb
    WHERE
        data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
        OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
) AS t
GROUP BY lang
ORDER BY count DESC, lang;
