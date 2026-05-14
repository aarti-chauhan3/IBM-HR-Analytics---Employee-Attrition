## IBM HR Analytics - Employee Attrition
                                                
### Turning workforce data into retention strategies through SQL, Python and Power BI

**Table of Contents**
1) Project Overview
2) Problem Statement
3) Project Workflow
4) Dashboard Preview
5) Key Business Insights

**Top Recommendations**
High-Risk Employee Profile
Tools & Technologies
Skills Demonstrated
Project Files

**1) Project Overview**

This HR Analytics project uses the IBM HR Analytics dataset with 1,470 employee records. We look at why employees leave using SQL, Python and Power BI. Our goal is to provide HR with data-backed recommendations.

| Metric | Value |
|---|---|
| Total Employees | 1,470 |
| Total Attrition | 237 |
| Retained Employees | 1,233 |
| Attrition Rate | 16.12% |


**2) Problem Statement**

The organization has an attrition rate of 16.12% higher than the industry benchmark. We need to understand why employees are leaving.
This project answers:
## Which departments and roles are losing employees?
## Is salary, overtime or career stagnation driving exits?
## What does a high-risk employee profile look like?

## Project Workflow

**1️⃣ Data Collection**
- Source: IBM HR Analytics Dataset — Kaggle
- 35 columns covering demographics, compensation, satisfaction, tenure and performance

**2️⃣ Excel — Data Exploration**
- Validated columns and data types
- Identified null values and inconsistencies

**3️⃣ Python — Exploratory Data Analysis**
- Attrition distribution
- Age group and gender based attrition
- Salary trend visualization
- Department wise attrition breakdown

**4️⃣ MySQL — Business Analysis**
- Structured SQL queries across 4 categories:
  - Attrition Analysis
  - Compensation Analysis
  - Job Satisfaction
  - Employee Profile

**5️⃣ Power BI — Interactive Dashboard**
- KPI Cards: Total Employees, Attrition Count, Retention Count, Attrition Rate
- Attrition by Department, Age Group, Tenure, Job Level
- Slicers: Department, Gender, Overtime
**4) Power BI Dashboard**
![HR Analytics Dashboard](Dashboard.png)

**5) Key Business Insights**

### A) Department Attrition
| Department | Employees Left | % of Total |
|---|---|---|
| Research & Development | 133 | 56.12% |
| Sales | 92 | 38.82% |
| Human Resources | 12 | 5.06% |

### B) Overtime Impact
| Overtime Status | Attrition Count | Attrition Rate |
|---|---|---|
| Yes | 127 | 30.5% |
| No | 110 | 10.4% |

### C) Salary Gap
| Employee Status | Avg Monthly Income |
|---|---|
| Left | ₹4,787 |
| Stayed | ₹6,833 |

## Top Recommendations

### Priority 1. Salary Correction
Fix salaries for Lab Technicians, Research Scientists and Sales Representatives.

### Priority 2. Overtime Management
Manage overtime for high-risk departments.

### Priority 3. Sales Executive Culture Audit
Investigate management quality and growth ceiling for Sales Executives.

## High-Risk Employee Profile

- **Department**: Research & Development
- **Age**: 30–35 years
- **Overtime**: Yes
- **Salary**: Below ₹4,000/month
- **Job Level**: 1 or 2

## Tools & Technologies

| Category | Tool |
|---|---|
| Data Source | IBM HR Analytics Dataset (Kaggle) |
| Data Exploration | Microsoft Excel |
| EDA & Cleaning | Python, Pandas, Matplotlib |
| Business Analysis | MySQL |
| Visualization | Power BI |

**Skills Demonstrated**
o	Data Cleaning & Validation
o	Exploratory Data Analysis (EDA)
o	Advanced SQL Query Writing
o	Business Insight Generation
o	KPI Reporting & Dashboard Development

## 👤 Author

**Aarti Chauhan**

I am a data analyst learner.
