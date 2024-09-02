# Overview:

This project delves into the data job market, concentrating on data analyst positions. It examines the highest-paying jobs, 
🔥 the most sought-after skills, and 📈 the intersection of high demand and high salaries in data analytics.

# Tools I Used
To thoroughly analyze the data analyst job market, I leveraged several essential tools:
### SQL
🛢️ SQL served as the foundation of my analysis, enabling me to interrogate the database and uncover crucial insights.
### PostgreSQL
PostgreSQL, the preferred database management system, was well-suited for managing the job posting data.
### Visual Studio Code
Visual Studio Code was my preferred choice for database management and running SQL queries.
### Git & GitHub
Git and GitHub were indispensable for version control and sharing my SQL scripts and analysis, facilitating collaboration and project tracking.


# Analysis
### 1. Skills essential for top paying jobs
To gain insight into the skills needed for the highest-paying positions, I combined job postings with skills data, revealing what employers prioritize for high-salary roles.
```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
![](https://github.com/samt138/SQL_Data_Analytics/blob/master/project_sql/587b0a1b-c77e-43b8-b018-d9ff79b3b2df.png?raw=true)

### 2. Skills required for Top Paying Jobs

To gain insight into the skills needed for the highest-paying positions, I combined job postings with skills data, revealing what employers prioritize for lucrative roles.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
### Foundational Skills Remain Key
SQL and Excel continue to be essential, underscoring the importance of solid skills in data processing and spreadsheet management.
### Technical Skills for Data Storytelling and Decision Support
Programming and visualization tools like Python, Tableau, and Power BI are crucial, highlighting the growing need for technical abilities in data analysis, presentation, and supporting decision-making processes.
| Skills        | Demand Count           | 
| ------------- |:-------------:| 
| Sql      | 7291 |
| Excel      | 4611     | 
| Python | 4330      | 

### 3. The Most Optimal Skills to learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| Skill ID        | Skills      | Demand Count    | Average Salary ($)   |
| ------------- |:-------------:|:---------------:|:---------------:| 
| 8             | go            | 27              | 115,320
| 234           | confluence    | 11              | 114,210
| 97            | hadoop        | 22              | 113,193
|80             | snowflake     | 37              | 112,948
|74             | azure         | 34              | 111,225

### Insights for above table
**In-Demand Programming Languages** :
Python and R are notable for their strong demand, with demand figures of 236 and 148, respectively. Although they are in high demand, the average salaries for these languages are approximately $101,397 for Python and $100,499 for R. 
This suggests that while expertise in these languages is highly sought after, it is also relatively common.

**Demand for Cloud and Big Data Skills**:
Skills in specialized cloud and big data technologies demonstrate strong demand and relatively high average salaries, underscoring their growing importance in data analysis. Some notable examples include:

*Snowflake*: A cloud data platform with a demand count of 148 and an average salary of $150,000

*Microsoft Azure*: A cloud computing service with a demand count of 236 and an average salary of $120, 

*Amazon Web Services (AWS)*: A cloud platform with a demand count of 236 and an average salary of $130. 

<br />These figures suggest that proficiency in cloud platforms and big data technologies is highly valued in the job market, as organizations increasingly rely on these tools for data storage, processing, and analysis. 
The combination of strong demand and competitive salaries indicates that skills in these areas are in short supply relative to the growing need.
