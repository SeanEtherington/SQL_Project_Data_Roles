/*
Questions to answer:

2. What are the skills required for these top-paying roles?
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact jp
    LEFT JOIN company_dim cd ON jp.company_id = cd.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC  
    LIMIT 10
)

SELECT 
    top_paying_jobs.*, -- *selects all from the top_paying_jobs table
    skills
FROM top_paying_jobs 
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC

/*
SQL had highest count in top paying jobs - 8, followed by python - 7, and tableau - 6
*/