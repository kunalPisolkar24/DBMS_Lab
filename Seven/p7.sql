CREATE TABLE Library (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    publication_year INT
);

-- Create the Library_Audit table to log old values
CREATE TABLE Library_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    title VARCHAR(255),
    author VARCHAR(255),
    publication_year INT,
    action VARCHAR(50), -- "DELETE" or "UPDATE"
    audit_timestamp TIMESTAMP
);


INSERT INTO Library (title, author, publication_year) VALUES
    ('Book 1', 'Author A', 2000),
    ('Book 2', 'Author B', 2010),
    ('Book 3', 'Author C', 2020);
    
DELIMITER //
CREATE TRIGGER BeforeLibraryDelete
BEFORE DELETE ON Library FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (book_id, title, author, publication_year, action, audit_timestamp)
    VALUES (OLD.book_id, OLD.title, OLD.author, OLD.publication_year, 'DELETE', NOW());
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER BeforeLibraryUpdate
BEFORE UPDATE ON Library FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (book_id, title, author, publication_year, action, audit_timestamp)
    VALUES (OLD.book_id, OLD.title, OLD.author, OLD.publication_year, 'UPDATE', NOW());
END;
//
DELIMITER ;

-- Create an AFTER DELETE trigger
DELIMITER //
CREATE TRIGGER AfterLibraryDelete
AFTER DELETE ON Library
FOR EACH ROW
BEGIN
     -- select (" Deletion Performed ");
END;
//
DELIMITER ;

-- Create an AFTER UPDATE trigger
DELIMITER //
CREATE TRIGGER AfterLibraryUpdate
AFTER UPDATE ON Library
FOR EACH ROW
BEGIN
	-- select (" Updation Performed ");
END;
//
DELIMITER ;

UPDATE Library
SET title = 'Updated Book', author = 'New Author'
WHERE book_id = 1;

DELETE FROM Library WHERE book_id = 2;

SELECT * FROM Library_Audit;

