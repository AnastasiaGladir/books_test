-- проверка на уникальный ISBN
CREATE OR REPLACE FUNCTION check_unique_isbn()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Books WHERE isbn = NEW.isbn AND book_id <> NEW.book_id) THEN
        RAISE EXCEPTION 'ISBN должен быть уникальным.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_unique_isbn
BEFORE INSERT OR UPDATE ON Books
FOR EACH ROW EXECUTE FUNCTION check_unique_isbn();

-- проверка возраста автора
CREATE OR REPLACE FUNCTION check_author_age()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.birth_date > CURRENT_DATE - INTERVAL '18 years' THEN
        RAISE EXCEPTION 'Автор должен быть старше 18 лет.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_author_age
BEFORE INSERT OR UPDATE ON Authors
FOR EACH ROW EXECUTE FUNCTION check_author_age();
