# Electric-Vehicle-Adaptation - Trends-Growth-Infrastructure (Europe)

# 🚗⚡ Electric Vehicle Adoption & Trends (2010–2024)

This project analyzes European electric vehicle (EV) trends using data from 2010 to 2024.
Last dataset update: **May 2025** (International Energy Agency – IEA).

The goal is to understand EV adoption growth, charging infrastructure expansion, and the environmental impact of the transition from combustion vehicles to electric mobility.  
The analysis combines **SQL for data transformation** and **Python for visualization**, producing actionable insights supported by clean and reproducible code.

---

## 📌 **Objectives & Scope**

This assessment answers the following key questions:

### 1) EV Adoption per Region — Brief Global View**  
*How has EV adoption evolved across major world regions from 2010 to 2024? Which regions show the strongest growth?*

### 2) Europe: EV Growth vs Charging Infrastructure**  
*Which European countries lead in EV acquisition vs charging point installation (Top 10 of each)?*

### 3) Europe: Highest Increase in EV Sales**  
*Which country recorded the largest increase in EV units over the observed period?*

### 4) Environmental Impact of EV Adoption**
#### 4.1 **How many gasoline cars could have been fueled with the petroleum avoided due to EV adoption?**  
#### 4.2 **How many households could have been powered using the electricity (GWh) consumed by EVs?**

Analysis is based on publicly available datasets from the **International Energy Agency**, collected and curated for the *Global EV Outlook 2025*.

🔗 Dataset source:  
https://www.iea.org/data-and-statistics/data-product/global-ev-outlook-2025#global-ev-data

---

## 🗂️ **Repository Structure**
├── data/
│ ├── ev_sales_macro_regions.csv
│ ├── ev_sales_countries.csv
│ ├── other_ev_data.csv
│ ├── electricity_demand.csv
│ ├── petroleum_avoidance.csv
│ └── ...
│
├── sql/
│ ├── 01_create_views.sql
│ ├── 02_ev_adoption_global.sql
│ ├── 03_europe_top_ev.sql
│ ├── 04_europe_charging_points.sql
│ ├── 05_ev_growth_europe.sql
│ ├── 06_petroleum_avoidance.sql
│ ├── 07_electricity_demand.sql
│ └── ...
│
├── notebooks/
│ └── analysis.ipynb (visualizations, plots, explanations)
│
├── images/
│ ├── ev_adoption_by_region.png
│ ├── ev_growth_by_region.png
│ ├── top_ev_eu.png
│ ├── top_cp_eu.png
│ ├── ev_growth_eu.png
│ ├── eu_cars_fueled_equivalent.png
│ ├── eu_homes_powered_equiv.png
│ └── ...
│
└── README.md


---

### 🛠️ **Technologies Used**

### ✅ SQL
- Data cleaning  
- Unpivoting (wide → long format)  
- Aggregations (SUM, GROUP BY)  
- Filtering by region/country groups  
- Calculating growth metrics  
- Creating reusable SQL views for analysis  

### ✅ Python (Pandas + Matplotlib)
- Data loading & cleaning  
- Line charts, bar charts, lollipop charts  
- Labeling values on points/bars  
- Exporting visualizations for presentation  

---

### 📊 **Key Findings (Summary)**

### **1. EV adoption has accelerated globally**
- Asia Pacific leads in total EV adoption.
- Europe and North America also show strong, consistent growth.
- Total EV sales globally exceed **77 million units** since 2010.

### **2. Europe’s EV market leaders**
- Top EV sellers in Europe (2024): *United Kingdom, Germany, France, Netherlands, Belgium.*
- Top charging point installers: *Netherlands, Germany, France, United Kingdom, Belgium.*

### **3. Highest EV growth in Europe**
- Countries with the steepest increase between 2010–2024:
  - **Germany**
  - **United Kingdom**
  - **France**
  - **Belgium**
  - **Netherlands**

Lollipop and bar charts illustrate these trends.

### **4. Environmental benefits**
- **>64 billion liters** of petroleum avoided globally (2010–2024).
- For Europe:
  - **2024:** 7.4 million households could be powered by EV charging electricity.

---

## 📈 **Visual Examples**
- EV Adoption per Region — Brief Global View
- EV Sales Growth by region
- Top EV Sales - Europe
- Top Public Charging Points - Europe
- EV Growth in Europe (2010 - 2024)
- Petroleum Displacement
- GWh Consumption and Comparision
