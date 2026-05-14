CREATE DATABASE ibm_hr_analytics;
USE ibm_hr_analytics;
CREATE TABLE hr_analytics(
Age	int not null,
Attrition varchar (5),
BusinessTravel varchar(50),
DailyRate int,
Department varchar(50),
DistanceFromHome int,	
Education varchar(50),	
EducationField varchar(50),
EmployeeCount int,	
EmployeeNumber int,	
EnvironmentSatisfaction	int,
Gender varchar(10),
HourlyRate int,
JobInvolvement  int,
JobLevel int,	
JobRole	varchar(50),
JobSatisfaction	int,
MaritalStatus varchar(10),
MonthlyIncome int,	
MonthlyRate	int,
NumCompaniesWorked int,
Over18 varchar(5),
OverTime varchar(5),	
PercentSalaryHike int,
PerformanceRating int,
RelationshipSatisfaction int,
StandardHours int,
StockOptionLevel int,	
TotalWorkingYears int,	
TrainingTimesLastYear int,	
WorkLifeBalance	int,
YearsAtCompany int,	
YearsInCurrentRole int,	
YearsSinceLastPromotion int,	
YearsWithCurrManager int);

SELECT count(*) from hr_analytics;

/* SHORT DESCRIPTION OF DATA
1) TOTAL EMPLOYEE = 1470
2) ATTRITION = 237 
3) ATTRITION RATE = 16.12% WHICH IS ABOVE DECENT BENCHMARK */

/* PURPOSE
* Analyze employee attrition patterns within the organization.
* Identify key factors affecting employee retention and turnover.
* Help HR make data-driven decisions to improve workforce stability. */


-- Category 1 — Attrition Analysis
-- Q1. What is the overall attrition rate and which department bleeds the most talent? 

SELECT Department,
COUNT(*) as attrition_count
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY department
ORDER BY attrition_count DESC;

-- INSIGHT: Overall attrition rate is 16.12% — above healthy benchmark of 10-15%
-- R&D lost 133 employees (56% of total attrition)
-- Sales lost 92 employees (39% of total attrition)
-- HR lost 12 employees (5% of total attrition)
-- R&D and Sales together account for 95% of company attrition
-- RECOMMENDATION: Immediate retention strategy needed for R&D and Sales
-- HR team should prioritise exit interviews in these two departments.

-- Q.2 Identify which job levels experience the highest attrition.

SELECT JobLevel,
COUNT(*) as attrition_count
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY JobLevel
ORDER BY attrition_count DESC;

-- INSIGHT: Job Level 1 shows the highest attrition with 143 employee exits
-- Job Level 2 (52) > Job Level 3 (32) > Job Level 4 (5) > Job Level 5 (5)
-- Attrition decreases as job level increases
-- Higher job levels demonstrate better employee retention
-- RECOMMENDATION: Focus on improving retention, career growth, and engagement for entry-level employees


-- Q.3 Are employees who work overtime leaving at a significantly higher rate than those who don't?

SELECT OverTime,
COUNT(*) as attrition_count
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY overtime;

-- INSIGHT: 127 overtime workers left vs 110 non-overtime workers
-- Overtime Yes → (127) 30.5% attrition rate
-- Overtime No → (110) 10.4% attrition rate
-- Overtime employees leave at 3X higher rate than non-overtime
-- RECOMMENDATION: Introduce overtime caps for high risk departments
-- Flag employees working 10+ extra hours weekly for manager check-in
-- Consider compensatory offs or overtime pay review


-- Q.4 Analyze attrition based on employee tenure.

SELECT YearsAtCompany,
COUNT(*) as attrition_count
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY YearsAtCompany
ORDER BY attrition_count DESC;

-- INSIGHT: Employees with lower tenure show the highest attrition
-- Majority of employee exits occur within the early years at the company
-- Attrition decreases as employee tenure increases
-- RECOMMENDATION: Improve early-stage employee engagement and retention strategies

-- Q.5 Which age group is most at risk of leaving — and should HR focus retention efforts there?

SELECT 
CASE 
WHEN Age < 20 THEN 'below 20'
WHEN Age BETWEEN 20 AND 29 THEN 'between 20 and 29'
WHEN Age BETWEEN 30 AND 40 THEN 'between 30 and 40'
ELSE 'after 40'
END as age_group,
COUNT(*) as attrition_count
FROM hr_analytics
WHERE Attrition='Yes'
GROUP BY age_group
ORDER BY attrition_count DESC;

-- INSIGHT: Age group 30-40 has highest attrition — 94 employees (40% of total leavers)
-- Age group 20-29 follows at 81 employees (34% of total leavers)
-- Together these two groups = 74% of all attrition
-- These two age groups account for the majority of employee exits
-- Employees in mid-career stages are at higher risk of leaving
-- RECOMMENDATION: Improve career growth, promotion opportunities, and compensation strategies for employees aged 20-40

-- Category 2 — Compensation Analysis
-- Q6. Is low salary driving attrition — do employees who left earn significantly less than those who stayed?

SELECT attrition,
round(avg(MonthlyIncome),2) as avg_salary
FROM hr_analytics
GROUP BY attrition;

-- INSIGHT: Employees who LEFT earned average ₹4,787/month
-- Employees who STAYED earned average ₹6,833/month
-- That is a ₹2,046 difference — 30% lower salary for leavers
-- Salary is clearly a significant driver of attrition
-- RECOMMENDATION: Conduct salary benchmarking against industry standards
-- Focus immediate salary corrections on R&D and Sales departments, where attrition is highest and salaries are lowest

-- Q.7 Which job roles are underpaid compared to their performance rating?

SELECT JobRole,
round(avg(MonthlyIncome),2) as avg_salary,
round(avg(PerformanceRating),2) as avg_performance
FROM hr_analytics
GROUP BY JobRole
ORDER BY avg_performance DESC, avg_salary ASC;

-- INSIGHT: Performance ratings are nearly identical across all roles (3.10-3.20)
-- But salary varies massively — from ₹2,626 to ₹17,181
-- Most underpaid despite good performance:
-- 1. Sales Representative — ₹2,626 (performance 3.14)
-- 2. Laboratory Technician — ₹3,237 (performance 3.16)  
-- 3. Research Scientist — ₹3,239 (performance 3.17)
-- Shocking finding: Research Director earns 5X more than Research Scientist
-- despite lower performance rating (3.10 vs 3.17)
-- Salary differences are driven by seniority/level — NOT performance
-- RECOMMENDATION: Review compensation structure for Sales Representatives, Lab Technicians,Sales Representatives
-- Consider performance-based pay increments to reward high performers regardless of seniority level

-- Category 3 — Job Satisfaction
-- Q8. Which departments have the lowest job satisfaction and environment satisfaction scores?

SELECT Department,
round(avg(JobSatisfaction),2) as job_satisfaction,
round(avg(EnvironmentSatisfaction),2) as env_satisfaction
FROM hr_analytics
GROUP BY Department
ORDER BY job_satisfaction DESC, env_satisfaction ASC;

-- INSIGHT: All departments score in medium range (2.60-2.75) on 1-4 scale
-- No department scores above 3 (High) — company wide satisfaction issue
-- HR department has the lowest job satisfaction, while Sales shows lower environment satisfaction
-- R&D scores most balanced across both metrics
-- RECOMMENDATION: Company wide initiative needed to improve satisfaction
-- Priority 1 — investigate HR department culture and workload
-- Priority 2 — improve physical and cultural work environment for Sales team
-- Consider anonymous employee satisfaction surveys quarterly

-- Q9. Does work life balance score affect attrition — are unhappy employees actually leaving?

SELECT Attrition,
round(avg(WorkLifeBalance),2) as worklife_balance
FROM hr_analytics
GROUP BY Attrition;

-- INSIGHT: Work life balance scores are nearly identical between
-- employees who left (2.66) and those who stayed (2.78)
-- Work-life balance alone does not appear to be a major driver of attrition
-- Salary gap, overtime, and limited career growth have stronger impact on employee turnover
-- RECOMMENDATION: HR should not focus retention budget on work life
-- overtime reduction
-- balance programs alone — salary correction and overtime management
-- will have higher impact on reducing attrition

-- Category 4 — Employee Profile
-- Q10. What does the profile of a high risk employee look like — age, department, salary, overtime combined?*/

SELECT Department, OverTime,
round(avg(Age),2) as avg_age,
round(avg(MonthlyIncome),2) as avg_income,
count(*) as attrition_count
FROM hr_analytics
WHERE Attrition='Yes'
GROUP BY Department, Overtime
ORDER BY attrition_count DESC;

-- INSIGHT: R&D employees working overtime show the highest attrition risk
-- Overtime employees in R&D earn lower average salaries than non-overtime employees
-- Sales employees also show high attrition despite comparatively better salaries, indicating non-monetary factors
-- High-risk profile identified: R&D employees aged around 33
-- working overtime
-- with salaries below ₹4,000
-- RECOMMENDATION: 
-- Focus on salary correction, overtime management, and retention strategies for high-risk R&D employees

-- Q11. Do employees who haven't been promoted in 3+ years show higher attrition?

SELECT Attrition,
round(avg(YearsSinceLastPromotion),2) as promotion_year,
count(*) as attrition_count
FROM hr_analytics
WHERE YearsSinceLastPromotion >=3
GROUP BY Attrition 
ORDER BY attrition_count DESC;

-- INSIGHT: Among employees with 3+ years without promotion:
-- 322 stayed (avg 6.78 years since last promotion)
-- 51 left (avg 7.02 years since last promotion)
-- Difference of only 0.24 years — minimal impact
-- 86% of employees stayed despite 3+ years without promotion
-- suggesting promotion alone is NOT a primary attrition driver
-- Attrition risk increases when promotion stagnation combines with low salary and overtime
-- Employees facing multiple dissatisfaction factors are more likely to leave
-- RECOMMENDATION: Monitor employees with long promotion gaps
-- especially those with low salary and overtime workload

-- Q13. Which job roles have the highest attrition despite good salary — suggesting non-monetary issues?

SELECT JobRole,
round(avg(MonthlyIncome),2) as salary,
count(*) as attrition_count
FROM hr_analytics
WHERE Attrition='Yes'
GROUP BY JobRole
ORDER BY attrition_count DESC;

-- INSIGHT: Most high-attrition roles are low-salary roles,
-- Indicating compensation is a major attrition driver.
-- Laboratory Technician (2919) — 62 left
-- Research Scientist (2780) — 47 left
-- Sales Representative (2364) — 33 left
-- Sales Executive showed high attrition despite good salary,
-- suggesting non-monetary factors like work pressure, management, or work-life balance issues.
-- RECOMMENDATION:
-- 1. Improve salary structure for low-paid high-attrition roles.
-- 2. Conduct culture and workload analysis for Sales Executive role.
-- 3. Use exit interviews to identify non-monetary attrition causes.


/* ================================================
OVERALL PROJECT RECOMMENDATIONS
================================================
Based on analysis of 1,470 employees with 16.12% attrition:

TOP 3 PRIORITIES FOR HR:

1. SALARY CORRECTION — IMMEDIATE
   Lab Technicians, Research Scientists, Sales Representatives
   earn 40-55% below company average despite matching performance ratings
   Direct cause of monetary attrition in these roles

2. OVERTIME MANAGEMENT — URGENT  
   Overtime workers leave at 3X higher rate (30.5% vs 10.4%)
   R&D overtime workers are overworked AND underpaid simultaneously
   Introduce overtime caps and mandatory comp-off policy

3. SALES EXECUTIVE CULTURE AUDIT — IMPORTANT
   57 Sales Executives left despite earning above average salary
   Non-monetary issue — investigate management, targets, growth ceiling
   Conduct anonymous exit interviews immediately

COMBINED HIGH RISK PROFILE:
Employee in R&D | Age 30-35 | Doing Overtime | Salary below ₹4,000
This profile should trigger automatic HR intervention
================================================ */
