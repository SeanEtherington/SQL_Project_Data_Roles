# Introduction

Exploring the dynamic world of data analysis through SQL, I aimed to refine my skills and uncover insights into top-paid roles and in-demand skills. This journey delves into salary trends, essential skills, and career pathways in today's data analyst job market.

*Note*: This data focuses on roles from the United States in 2023 due to the amount of roles in Australia being limited in this dataset. A future reccomendation would be to explore data job postings based in Australia so that I could gain a better understanding of the local job market and associated skills. 

SQL Queries, Check them our here: [SQL_Project_Data_Job_Analysis](/SQL_Project_Data_Job_Analysis/)

# Background
I wanted to work on this project for two main reasons:
1. Further develop and refine my SQL knowledge and application ability.
2. Explore the top-paid and in-demand skills for data related roles so that I could be better informed of the job market.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.

- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by the average yearly salary. This query highlights the high paying opportunities in the field.
``` sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact jp
LEFT JOIN company_dim cd ON jp.company_id = cd.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC  
LIMIT 10
```
- **Wide Salary Range:** The top 10 paying data analyst roles range from $184,000 to $650,000 annually, highlighting substantial earning potential within the field.
- **Diverse Employers:** Companies such as SmartAsset, Meta, and AT&T offer competitive salaries, indicating widespread interest across diverse industries.
- **Job Title Variety:** The dataset includes a variety of job titles ranging from Data Analyst to Director of Analytics, showcasing diverse roles and specializations within the field of data analytics.

![Top_Paying_jobs](SQL_Project_Data_Job_Analysis/average_salary_by_job_title.png)

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, which provided insights into what skills employers value for high-compensation roles.

``` sql
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

```
- **SQL, Python, and R:** These skills are widely demanded across data analyst roles, reflecting their importance in data manipulation, analysis, and statistical modeling. Jobs requiring these skills offer competitive salaries, ranging from approximately $184,000 to $650,000 annually.

- **Azure and AWS:** Cloud computing skills like Azure and AWS are increasingly valued, indicating a shift towards data storage, management, and processing in cloud environments. Roles requiring these skills also offer lucrative salaries, aligning with the high demand for cloud expertise in data analytics.

- **Excel, Tableau, and Power BI:** Proficiency in data visualization tools such as Excel, Tableau, and Power BI is essential for interpreting and presenting data insights effectively to stakeholders. Jobs requiring these skills show a wide salary range, highlighting their critical role in data-driven decision-making across organizations.

- **Programming Libraries (Pandas, NumPy):** Specific libraries like Pandas and NumPy for Python are crucial for data manipulation and analysis tasks. Roles that emphasize these skills often come with salaries reflecting their technical complexity and the specialized knowledge required.

An example of a job is the Associate Director - Data Insights position at AT&T, offering an annual salary of $255,829 This role requires expertise in SQL, Python, and R for data manipulation and analysis, along with proficiency in Azure for cloud-based data management. 

### 3. In-Demand Skills for Data Analysts

This query highlighted the skills that appear most frequently in job postings:
``` sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```
Heres the breakdown of the most demanded skills for data analysts:
| Skills   | Demand Count |
|----------|--------------|
| sql      | 92628        |
| excel    | 67031        |
| python   | 57326        |
| tableau  | 46554        |
| power bi | 39468        |

- **SQL:** Tops the list with 92,600 mentions, highlighting its pivotal role in querying databases, data retrieval, and management. Its widespread use underscores its fundamental importance in data analysis and decision-making processes across various industries.

- **Excel:** Follows closely with 67,000 mentions, renowned for its versatility in data organization, basic analysis, and reporting. 

- **Python:** Ranks third with 57,300 mentions, valued for its extensive libraries and capabilities in data manipulation, statistical analysis, and machine learning. 

- **Tableau:** Noted in 46,600 postings, essential for its advanced data visualization capabilities. 

- **Power BI:** Valued in 39,500 listings, known for its robust business intelligence tools. 

These skills collectively highlight the diverse technical competencies required in data analyst roles, encompassing data querying, manipulation, visualization, and business intelligence. 

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying in the job market context:

``` sql
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
```
| Skills    | Average Salary |
|-----------|-----------------|
| svn       | 400000          |
| solidity  | 179000          |
| couchbase | 160515          |
| datarobot | 155486          |
| golang    | 155000          |
| mxnet     | 149000          |
| dplyr     | 147633          |
| vmware    | 147500          |
| terraform | 146734          |
- **SVN:** Specialized skills in SVN command high average salaries, reaching up to $400,000 annually, reflecting their niche and high-demand nature in software version control.

- **Solidity:** Essential for blockchain development, Solidity skills offer an average salary of $179,000, indicating its pivotal role in emerging technologies and decentralized applications.

- **Couchbase:** With an average salary of $160,515, Couchbase skills underscore their critical importance in efficient database management and NoSQL data handling.

- **DataRobot, Golang, and MXNet:** Skills in DataRobot, Golang (Go programming language), and MXNet are also highly valued, offering competitive salaries and highlighting their significance in advanced data analytics, programming, and machine learning environments.


### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development:
``` sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skill_id, 
    skills_dim.skills
HAVING 
    AVG(job_postings_fact.salary_year_avg) > 100000
ORDER BY 
    demand_count DESC, 
    avg_salary DESC 
LIMIT 30;
```

- **Python:** With 1,840 job postings and an average salary of $101,500, stands out due to its widespread use in data analysis, machine learning, and automation. Its strong demand underscores its versatility across various industries offering competitive pay to skilled professionals.

- **Oracle:** With 332 job postings and an average salary of $100,900, Oracle continues to be a staple in database management systems. 

- **Azure and AWS:** Azure had 319 job postings with an average salary of $105,400, while AWS follows closely with 291 postings averaging $106,400. These figures highlight the robust demand for cloud computing expertise, essential for modern data storage, management, and analysis solutions. 
- **Snowflake:** With 241 job postings and an average salary of $111,600, Snowflake represents specialized expertise in cloud-based data warehousing. 

Below are the top 15 Optimal Skills:

| Skill ID | Skills      | Demand Count | Average Salary |
|----------|-------------|--------------|----------------|
| 1        | python      | 1840         | 101512         |
| 79       | oracle      | 332          | 100964         |
| 74       | azure       | 319          | 105400         |
| 76       | aws         | 291          | 106440         |
| 185      | looker      | 260          | 103855         |
| 80       | snowflake   | 241          | 111578         |
| 92       | spark       | 187          | 113002         |
| 233      | jira        | 145          | 107931         |
| 97       | hadoop      | 140          | 110888         |
| 4        | java        | 135          | 100214         |
| 201      | alteryx     | 124          | 105580         |
| 2        | nosql       | 108          | 108331         |
| 75       | databricks  | 102          | 112881         |
| 187      | qlik        | 100          | 100933         |
| 204      | visio       | 99           | 101036         |

# What I Learned

Throughout this journey, I've significantly enhanced my SQL skills with advanced techniques. Specifically, I have learnt:

- **Mastering Complex Queries:** I've greatly improved upon my ability to complete intricate SQL queries, seamlessly merging tables and employing WITH clauses for sophisticated temporary table operations.

- **Expert Data Aggregation:** I've become proficient in utilizing GROUP BY and harnessing aggregate functions like COUNT() and AVG() to efficiently summarize and analyze data.

- **Analytical Mastery:** I've elevated my ability to solve real-world challenges with SQL, transforming complex questions into actionable insights through strategic query design.


# Conclusion

In this exploration of the data analyst job market using SQL, several key insights emerged:

1. **Top-Paying Jobs:** The top-paying data analyst roles range from $184,000 to $650,000 annually, showcasing significant earning potential across diverse industries like finance, technology, and telecommunications.

2. **Skills in Demand:** SQL, Python, and cloud computing skills like Azure and AWS are highly sought-after, reflecting their critical role in data manipulation, analysis, and cloud-based data management solutions.

3. **Skills and Salaries:** Specialized skills such as SVN, Solidity, and Couchbase command high average salaries, indicating their niche and in-demand nature in areas like version control, blockchain development, and database management.

4. **Strategic Skill Development:** Python, Oracle, Azure, AWS, and Snowflake emerge as optimal skills to learn, offering both high demand and competitive salaries, underscoring their importance in today's data-driven job market.

### Closing Thoughts
Through advanced SQL techniques, I've deepened my understanding of job trends, skill requirements, and salary dynamics in the data analyst field, enhancing my ability to navigate and excel in this competitive landscape.