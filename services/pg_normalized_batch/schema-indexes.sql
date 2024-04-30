CREATE INDEX idx_tweet_tags ON tweet_tags(tag);

CREATE INDEX idx_count_tags ON tweet_tags(tag, id_tweets);

CREATE INDEX idx_lang ON tweets(id_tweets, lang);

CREATE INDEX idx_txt ON tweets USING GIN(to_tsvector('english', text)) WHERE lang = 'en';
