/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
select '#' || t.hashtag as tag, count(*) as count
from (
    select distinct
        data->>'id' as id_tweets,
        jsonb_array_elements(data->'entities'->'hashtags' || COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'))->>'text' as hashtag
    from tweets_jsonb
    where to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
      and data->>'lang' = 'en'
) as t
group by t.hashtag
order by count desc, t.hashtag
limit 1000;
