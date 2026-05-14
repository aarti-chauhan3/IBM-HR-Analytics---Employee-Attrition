# IBM HR Analytics — Basic EDA
# Dataset: IBM HR Employee Attrition — 1,470 employees

import pandas as pd
import matplotlib.pyplot as plt

# STEP 1 — LOAD DATA
df = pd.read_csv('IBM HR Employee Attrition.csv')

# STEP 2 — BASIC EXPLORATION
print("Shape:", df.shape)
print("\nMissing values:\n", df.isnull().sum())
print("\nBasic stats:\n", df.describe())

# STEP 3 — ATTRITION OVERVIEW
print("\nAttrition Count:")
print(df['Attrition'].value_counts())

attrition_rate = round((df['Attrition']=='Yes').sum() / len(df) * 100, 2)
print(f"\nAttrition Rate: {attrition_rate}%")

# STEP 4 — ATTRITION BY DEPARTMENT
dept = df[df['Attrition']=='Yes']['Department'].value_counts()
print("\nAttrition by Department:\n", dept)

# STEP 5 — SALARY COMPARISON
salary = df.groupby('Attrition')['MonthlyIncome'].mean().round(2)
print("\nAvg Salary by Attrition:\n", salary)

# STEP 6 — OVERTIME VS ATTRITION
overtime = df[df['Attrition']=='Yes']['OverTime'].value_counts()
print("\nOvertime vs Attrition:\n", overtime)