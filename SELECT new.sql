SELECT genre_name, COUNT(artist_id) FROM Genres g
JOIN artistsgenres ag ON g.genre_id = ag.genre_id
GROUP BY g.genre_name
ORDER BY COUNT(artist_id) DESC;

SELECT name, COUNT(*) FROM tracks t
JOIN albums a on t.album_id = a.album_id
WHERE a.year = 2019 or a.year = 2020
GROUP BY a.name
/* способ 1, но тут надо все песни вносить*/

SELECT name, sum(track_count) FROM albums
WHERE year = 2019 or year = 2020
GROUP BY name
/* способ 2*/

SELECT name, AVG(track_duration) FROM tracks t
JOIN albums a on a.album_id = t.album_id
GROUP BY a.name
ORDER BY AVG(track_duration) DESC;


SELECT artist_name FROM artists art
WHERE artist_name not in (
SELECT artist_name FROM artists art
JOIN artistsalbum aa on art.artist_id = aa.artist_id
JOIN albums al on al.album_id = aa.album_id
WHERE year = 1986);


SELECT c.name from compilation c
JOIN compilationtracks ct on ct.compilation_id = c.compilation_id
JOIN tracks t on t.track_id = ct.track_id
JOIN albums al on al.album_id = t.album_id
JOIN artistsalbum aa on aa.artist_id = al.album_id
JOIN artists a on a.artist_id = aa.artist_id
WHERE a.artist_name = 'Chet Baker'


SELECT a.name FROM Albums a
JOIN artistsalbum aa ON aa.album_id = a.album_id
JOIN artists art ON art.artist_id = aa.artist_id
JOIN artistsgenres ag ON ag.artist_id = art.artist_id
JOIN genres g ON g.genre_id = ag.genre_id
GROUP BY a.name
HAVING COUNT(g.genre_name) > 1

SELECT t.track_name from tracks t
LEFT JOIN compilationtracks ct on ct.track_id = t.track_id
LEFT JOIN compilation c on c.compilation_id = ct.compilation_id
WHERE c.compilation_id is null


SELECT artist_name FROM artists art
JOIN artistsalbum aa on art.artist_id = aa.artist_id
JOIN albums al on al.album_id = aa.album_id
JOIN tracks t on t.album_id  = al.album_id
where track_duration =
(select min(track_duration) from tracks)


SELECT a.name FROM albums a
JOIN tracks t on t.album_id = a.album_id
GROUP BY a.name
having count(t.track_id) = (
SELECT count(t.track_id) FROM albums a
JOIN tracks t on t.album_id = a.album_id
GROUP BY a.name
ORDER BY COUNT(t.track_id) asc
LIMIT 1)
