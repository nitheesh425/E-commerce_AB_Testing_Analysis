E-Commerce Checkout A/B Testing Analysis
📌 Project Overview

This project analyzes the impact of a redesigned e-commerce checkout page using A/B testing. The analysis compares two groups:

Control: Existing checkout experience
Treatment: Redesigned checkout experience

The main objective is to determine whether the redesigned checkout improves purchase conversion while maintaining important business metrics such as Add-to-Cart Rate, Checkout Rate, Average Order Value (AOV), and Revenue per User.

The project follows a complete data analytics workflow using Excel, PostgreSQL, Python, and Power BI.

🛠️ Tools & Technologies
Excel – Data cleaning, KPI analysis and initial analysis
PostgreSQL – SQL data analysis
Python – Statistical testing and exploratory data analysis
Pandas & NumPy – Data manipulation
SciPy – Statistical analysis
Matplotlib – Data visualization
Power BI – Interactive dashboard
DAX – KPI and statistical calculations
📊 Dataset

The dataset contains 50,000 e-commerce users and includes:

User ID
Experiment Group
Date
Device
Country
Traffic Source
Sessions
Session Duration
Product Views
Add to Cart
Checkout Started
Purchased
Order Value
Revenue per User
🔄 Project Workflow
Raw Dataset
     ↓
Data Cleaning
     ↓
Exploratory Data Analysis
     ↓
KPI Analysis
     ↓
PostgreSQL Analysis
     ↓
A/B Statistical Testing
     ↓
Segment Analysis
     ↓
Power BI Dashboard
     ↓
Business Recommendation
🧪 A/B Testing
Hypotheses

Null Hypothesis (H₀):
There is no difference in purchase conversion between the Control and Treatment groups.

Alternative Hypothesis (H₁):
There is a difference in purchase conversion between the Control and Treatment groups.

A two-proportion z-test was used with a significance level of 5% (α = 0.05).

The analysis calculated:

Conversion Rate
Conversion Difference
Relative Uplift
Z-score
P-value
95% Confidence Interval
📈 Key Results
Metric	Control	Treatment
Users	24,814	25,186
Conversion Rate	7.79%	8.03%
Conversion Uplift	—	3.01%
P-value	—	33.19%
AOV	₹893.39	₹881.73
Revenue per User	₹69.63	₹70.79
Statistical Conclusion

The Treatment group achieved a 3.01% relative increase in conversion.

However, the p-value is 33.19%, which is greater than the 5% significance level.

Therefore, the result is:

Not Statistically Significant

The 95% confidence interval for the conversion difference is approximately:

-0.24% to +0.71%

This means there is insufficient statistical evidence to conclude that the redesigned checkout significantly improved conversion.

🔍 Segment Analysis

The experiment was analyzed across different customer segments:

Device
Desktop
Mobile
Tablet
Country
India
USA
Canada
UK
Australia
Traffic Source
Organic
Email
Paid Search
Social
Direct

These analyses help identify segments where the Treatment experience may perform differently.

📊 Power BI Dashboard

The Power BI dashboard includes:

Executive Overview
Total Users
Control Conversion
Treatment Conversion
Conversion Uplift
P-value
Revenue per User
Control vs Treatment comparison
Statistical result
Confidence interval
Funnel Analysis
Add to Cart
Checkout Started
Purchased
Control vs Treatment comparison
Segment Analysis
Conversion by Device
Conversion by Country
Conversion by Traffic Source
A/B Test Results
Conversion Difference
Relative Uplift
P-value
95% Confidence Interval
Statistical Decision
Business Recommendation
💡 Business Recommendation

The redesigned checkout showed a positive descriptive improvement in conversion and revenue per user. However, the conversion improvement was not statistically significant.

Therefore, the redesigned checkout should not yet be considered a proven improvement.

A longer experiment or larger sample size is recommended before making a final rollout decision. AOV should also be monitored because it decreased slightly while conversion increased.

🚀 Skills Demonstrated
Data Cleaning
Excel
SQL
PostgreSQL
Python
Pandas
NumPy
SciPy
Matplotlib
A/B Testing
Hypothesis Testing
Statistical Analysis
Power BI
DAX
KPI Development
Data Visualization
Business Analysis
Data Storytelling
