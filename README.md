# Airline Operations Performance Analysis

## Project Overview
This project analyses 631,970 airline flight records from July 2026 to identify patterns in operational performance, delays, cancellations and route disruptions.

I completed the analysis using SQL for exploratory analysis and Power BI for visualisation and management reporting.

The objective was to turn a large operational dataset into clear insights that could support data-driven decision-making.

## Tools Used
- SQL (SQLite)
- Power BI
- Power Query
- DAX
- Excel

## Business Questions
The analysis explored:

- What proportion of flights are cancelled or diverted?
- Which airports and routes experience the greatest delays?
- What are the largest recorded contributors to delay minutes?
- Does operational performance vary by time of day?
- Which high-volume routes should be prioritised for further investigation?

## Key Findings

### Delay Drivers
Late-arriving aircraft accounted for approximately **41.8% of recorded delay-cause minutes**, making it the largest recorded contributor.

Carrier-related delays represented a further **31.7%**.

Together, these categories accounted for approximately **73.5% of recorded delay-cause minutes**.

### Time-of-Day Performance
Average arrival delay increased substantially later in the day:

- Morning: **2.78 minutes**
- Afternoon: **22.52 minutes**
- Evening: **30.18 minutes**
- Night: **19.05 minutes**

Evening departures therefore experienced the highest average arrival delay.

### Route Performance
Analysis of routes with at least 500 scheduled flights identified several high-volume routes experiencing substantial delays.

**ATL → EWR** recorded the highest average arrival delay within this group at approximately **42 minutes across 519 scheduled flights**.

The analysis also identified concentrations of poor performance among several **SFO-bound** and **ATL-originating** routes.

### Cancellations
The overall cancellation rate was approximately **2.62%**.

Further airport-level analysis identified substantial variation in cancellation rates between airports, highlighting locations for further operational investigation.

## Power BI Dashboard
The Power BI dashboard provides an executive-level overview of operational performance, including:

- Total flight volume
- Cancellation rate
- Average arrival delay
- Recorded delay causes
- Performance by time of day

The dashboard was designed to translate the SQL analysis into accessible management information.

## Recommendations
Based on the analysis:

1. Investigate aircraft rotation and turnaround processes associated with late-arriving aircraft, as this represents the largest recorded category of delay minutes.
2. Review operational resilience during afternoon and evening periods, when average arrival delays are substantially higher.
3. Prioritise investigation of high-volume routes experiencing persistent poor performance.
4. Examine recurring disruption among SFO-bound routes to understand contributing operational and network factors.

These findings identify areas for further investigation rather than establishing direct causation.

## Dataset
U.S. Bureau of Transportation Statistics – Reporting Carrier On-Time Performance Data, July 2026.

The dataset contains 631,970 flight records covering scheduled flight operations, arrival performance, cancellations, diversions and recorded delay causes.

## Limitations
- The analysis covers a single month and may therefore be affected by seasonal factors.
- The dataset represents U.S. airline operations and is not British Airways operational data.
- The analysis identifies associations and patterns rather than proving the causes of disruption.
- Minimum flight-volume thresholds were used in route and airport comparisons to reduce the influence of very small samples.
