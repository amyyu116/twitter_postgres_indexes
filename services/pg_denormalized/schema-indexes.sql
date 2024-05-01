CREATE INDEX idx_hashtags ON tweets_jsonb USING GIN ((data->'entities'->'hashtags'));

CREATE INDEX idx_extended_hashtags ON tweets_jsonb USING GIN ((data->'extended_tweet'->'entities'->'hashtags'));

CREATE INDEX idx_lang_id_tweets ON tweets_jsonb ((data ->>'id'), (data->>'lang'));

CREATE INDEX idx_tweets_text_lang ON tweets_jsonb USING GIN (to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text', data->>'text'))) WHERE (data ->> 'lang'='en');

CREATE INDEX idx_lang_en ON tweets_jsonb USING GIN(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))) WHERE (data->>'lang'='en');
