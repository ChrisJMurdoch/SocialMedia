
/* getFollowableUsers() */
SELECT users.* FROM users
	WHERE users.username != '[USERNAME]'
EXCEPT SELECT users.* FROM
	users JOIN
	following ON users.username = following.followed
	WHERE following.follower = '[USERNAME]';

/* getUserPosts() */
SELECT posts.*, COUNT(awards) AS likes, bool_or(awards.sender = '[OBSERVER]') as liked FROM
	posts LEFT JOIN
	awards ON posts.id = awards.post AND awards.award = 'like'
	WHERE posts.username = '[USERNAME]'
	GROUP BY posts.id
	ORDER BY posts.posted_at DESC;

/* getNewsfeedPosts() */
SELECT DISTINCT posts_with_likes.* FROM
	(
		SELECT posts.*, COUNT(awards) AS likes, bool_or(awards.sender = '[OBSERVER]') as liked FROM
			posts LEFT JOIN
			awards ON posts.id = awards.post AND awards.award = 'like'
			GROUP BY posts.id
	) AS posts_with_likes JOIN
	following ON posts_with_likes.username = following.followed AND ( following.follower = '[USERNAME]' OR posts_with_likes.username = '[USERNAME]' )
	ORDER BY posts_with_likes.posted_at DESC;

/* mostLikes() */
SELECT users.username, users.has_avatar, COUNT(awards) AS likes FROM
	users LEFT JOIN
	posts ON users.username = posts.username LEFT JOIN
	awards ON posts.id = awards.post AND awards.award = 'like'
	GROUP BY users.username
	ORDER BY likes DESC
	LIMIT 5;