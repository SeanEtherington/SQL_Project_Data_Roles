--4. What are the top skills based on salary for my role?


SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 15



SELECT 
    skills_dim.skills,
    job_postings_fact.salary_year_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst' AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skills, job_postings_fact.salary_year_avg
ORDER BY job_postings_fact.salary_year_avg DESC
LIMIT 15;

--Use the first query if you want to see each unique salary value for each skill.
--Use the second query if you want to see the average salary for each skill across all job postings.