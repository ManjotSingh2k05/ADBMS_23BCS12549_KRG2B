CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    age INT,
    class INT
);

DO $$
BEGIN TRANSACTION 
    BEGIN 
        INSERT INTO students(name, age, class) VALUES ('Anisha',16,8);
		INSERT INTO students(name, age, class) VALUES ('Mayank',19,9);
        INSERT INTO students(name, age, class) VALUES ('Anisha',17,8); 
        INSERT INTO students(name, age, class) VALUES ('Mayank',19,9);

        RAISE NOTICE ' Transaction Successfully Done';

    EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'Transaction Failed..! Rolling back changes.';
            RAISE; 
    END;
END;
$$;


















































