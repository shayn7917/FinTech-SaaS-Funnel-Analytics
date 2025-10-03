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

<img width="1396" height="786" alt="image" src="https://github.com/user-attachments/assets/66d5a9cf-5467-4d87-85a8-4386330aaf12" />

🔹 Business Insights

Severe Funnel Drop-off:

Out of 5000 created orders, only 2 reached completion.

That’s a completion rate of just 0.04%, highlighting a critical leakage.

High Early Engagement, Poor Conversion:

2484 users interacted, meaning almost 50% engagement rate.

But only 411 attempted login (~16%), showing a big gap between interest and action.

Authentication Bottleneck:

135 successful logins out of 411 attempts → 32.85% login success rate.

Suggests users are struggling at the login stage (bad UX, errors, or mistrust).

MFA Stage is a Major Barrier:

Only 74 users reached MFA out of 135 logins → ~55% drop-off.

Security is important, but this friction is killing conversions.

Pull-through Rate is Critically Low:

Only 0.08% of users who interacted completed the funnel.

Indicates urgent need for product and onboarding optimization.


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


