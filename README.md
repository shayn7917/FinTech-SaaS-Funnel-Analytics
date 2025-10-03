📊 SaaS Funnel Analytics Project
🔹 Overview

This project simulates a FinTech SaaS user funnel and analyzes stage-wise drop-offs using:

Python → generated synthetic funnel event logs

MySQL → ETL and funnel transformation queries

Power BI → interactive funnel dashboard and KPIs

The goal is to show end-to-end data analytics workflow: data ingestion → transformation → metrics → visualization → business recommendations.

🔹 Dataset

Synthetic dataset of 5,000 orders, each going through different funnel stages:

Created → Interacted → Login Attempt → Login Success → MFA → Completed

Possible outcomes: Error, Timeout, Cancelled, Churned

File: data/Funnel_Logs.csv

🔹 SQL Logic
1. Create Table

sql/create_table.sql

<img width="829" height="219" alt="image" src="https://github.com/user-attachments/assets/1a27386b-9a31-40b1-a7e5-844a33537144" />

2. Map Funnel Stages

sql/stage_mapping.sql

Maps raw status codes into StageLevels (Created=0, Interacted=1, Completed=7, etc.).

3. Funnel KPIs

sql/funnel_mapping.sql

Computes:

Activation Rate = Interacted ÷ Created

Login Success Rate = Login Success ÷ Login Attempted

Completion Rate = Completed ÷ Interacted

Pullthrough Rate = Completed ÷ Created

<img width="1156" height="109" alt="image" src="https://github.com/user-attachments/assets/e37db352-9b84-441e-a43b-f94b78b0a223" />

4. Power BI Query

sql/powerbi_query.sql

Outputs stage counts, ready for Power BI funnel charts.

🔹 Power BI Dashboard

Funnel chart visualizing drop-offs at each stage

KPI cards for Activation, Completion, and Pullthrough rates

Time-series of completions by month











🔹 Business Insights

~50% of orders activate after signup → onboarding works well.

Only ~33% of login attempts succeed → major friction at login.

Completion is <1% → MFA and VOIE are strong bottlenecks.

Recommendation: simplify login/MFA, improve UX in verification flow to reduce drop-offs.


🔹 How to Run Locally

Create schema in MySQL:

<img width="392" height="83" alt="image" src="https://github.com/user-attachments/assets/8ed107a8-3390-4bac-aa41-c5db930c0988" />

Run 01_create_table.sql

Import data/Funnel_Logs.csv into FunnelLogs table

Run queries in sql/02_stage_mapping.sql → sql/03_funnel_metrics.sql

Connect Power BI to MySQL or use 04_powerbi_query.sql directly

🔹 Tech Stack

Database: MySQL

Visualization: Power BI

Data Generation: Python (synthetic dataset)


