/* 

Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' as 'Local'
-  Otherwise 'Onsite'

*/

SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst' -- Filter further for Data Analyst jobs
GROUP BY
    location_category;

/*
Creating a subquery to check whether job_no_degree_mentiob is null or not
*/

SELECT name AS company_name
FROM 
    company_dim
WHERE company_id IN(
    SELECT 
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

-- Creating subqueries for Commom Table Expression (CTE)

/*
Find the companies that have the most job openings.
- Get the total number of job postings per company id
- Return the total number of jobs with the company name
*/

WITH company_job_count AS (
    SELECT
            company_id,
            COUNT(*) AS total_jobs
    FROM
            job_postings_fact
    GROUP BY
            company_id
)   

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM   
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC

/*
Find the count of the number of remote job posting per skills
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM    
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = True AND 
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills on skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;