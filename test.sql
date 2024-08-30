CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

-- Creating sample data
INSERT INTO job_applied 
    (job_id, 
    application_sent_date, 
    custom_resume, 
    resume_file_name, 
    cover_letter_sent, 
    cover_letter_file_name, 
    status)
VALUES (1,
        '2024-02-01',
        true,
        'resume_01.pdf',
        true,
        'cover_letter.pdf',
        'submitted'),
        (2,
        '2024-02-02',
        false,
        'resume_02.pdf',
        false,
        NULL,
        'interview scheduled'),
        (3,
        '2024-02-03',
        true,
        'resume_03.pdf',
        true,
        'cover_letter3.pdf',
        'ghosted'),
        (4,
        '2024-02-04',
        false,
        'resume_04.pdf',
        false,
        NULL,
        'rejected'),
        (5,
        '2024-02-05',
        true,
        'resume_05.pdf',
        true,
        'cover_letter5.pdf',
        'rejected');


-- Altering the table
ALTER TABLE job_applied
ADD Contact VARCHAR(50);

-- Updating Contact Column
UPDATE job_applied
SET Contact = 'Josh Harris'
WHERE job_id = 1;

UPDATE job_applied
SET Contact = 'John Doe'
WHERE job_id = 2;

UPDATE job_applied
SET Contact = 'Jane Doe'
WHERE job_id = 3;

UPDATE job_applied
SET Contact = 'Harris Smith'
WHERE job_id = 4;

UPDATE job_applied
SET Contact = 'Jane Smith'
WHERE job_id = 5;

-- To Rename a Column
ALTER TABLE job_applied
RENAME COLUMN Contact TO Contact_Name;

-- To Change Datatype
ALTER TABLE job_applied
ALTER COLUMN Contact_Name TYPE TEXT;

/* 
To Drop Column
ALTER TABLE job_applied
DROP COLUMN Contact_Name;

To Drop Entire table
DROP TABLE job_applied;
*/

