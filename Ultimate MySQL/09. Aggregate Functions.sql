/*How many books are in the database???!*/
SELECT COUNT(*) FROM books;

/*How many author_fnames?*/
SELECT COUNT(DISTINCT(author_fname))
FROM books;

/*How many author_lfnames?*/
SELECT COUNT(DISTINCT(author_lname))
FROM books;

/*How many titles contain "the"?*/
SELECT COUNT(*) FROM books
WHERE title LIKE '%the%'