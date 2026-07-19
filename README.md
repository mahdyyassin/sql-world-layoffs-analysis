# World Layoffs SQL Data Cleaning & Analysis

## Project Overview

This project analyzes a global layoffs dataset using SQL. The project covers the complete data workflow, including data cleaning, preprocessing, and exploratory data analysis (EDA) to uncover trends in layoffs across companies, industries, countries, and years.

## Dataset

The dataset contains information about layoffs worldwide, including:

* Company
* Industry
* Country
* Number of employees laid off
* Percentage laid off
* Funding raised
* Company stage
* Date of layoff

## Data Cleaning Tasks

The cleaning process was performed entirely in SQL and included:

* Removing duplicate records using window functions
* Creating staging tables to preserve raw data
* Standardizing company, industry, and country names
* Converting date fields to proper SQL date format
* Handling missing and null values
* Populating missing industry values where possible
* Removing irrelevant rows and columns

## Exploratory Data Analysis

The analysis included:

* Total layoffs by company
* Total layoffs by industry
* Total layoffs by country
* Total layoffs by year
* Date range analysis
* Monthly rolling layoffs trend using window functions
* Top 5 companies with the highest layoffs each year using DENSE_RANK()

## SQL Concepts Used

* CTEs (Common Table Expressions)
* Window Functions
* ROW_NUMBER()
* DENSE_RANK()
* Aggregate Functions
* GROUP BY
* JOINs
* Data Cleaning Techniques
* Date Functions
* Rolling Aggregations

## Key Insights

* Identified companies with the highest layoffs globally.
* Analyzed industries most affected by workforce reductions.
* Examined yearly layoff trends.
* Generated cumulative monthly layoff trends using rolling totals.
* Ranked top companies by layoffs within each year.

## Tools Used

* MySQL
* SQL
* GitHub

## Files

* World Layoffs (SQL data cleaning).sql
* World Layoffs (SQL data analysis).sql
* layoffs.csv
