# =============================================================================
# Walmart Sales Data — Exploratory Data Analysis (EDA)
# =============================================================================
# Author   : Anshul Jangra
# Dataset  : Walmart.csv
# Purpose  : Clean and explore Walmart transactional sales data to uncover
#            patterns in revenue, product categories, and payment behaviour.
# Tools    : Python 3.x · pandas
# =============================================================================

import pandas as pd

# -----------------------------------------------------------------------------
# 1. LOAD DATA
# -----------------------------------------------------------------------------
# Read the raw CSV from local storage. Update the path if running elsewhere.
df = pd.read_csv(r"C:\Users\Anshul Jangra\Desktop\Walmart\data\Walmart.csv")

# -----------------------------------------------------------------------------
# 2. INITIAL INSPECTION
# -----------------------------------------------------------------------------
# Preview the first five rows to confirm the data loaded correctly.
print("--- First 5 Rows ---")
print(df.head())

# Check the number of rows and columns.
print("\n--- Shape (rows, columns) ---")
print(df.shape)

# Review column names, non-null counts, and inferred data types.
print("\n--- Column Info ---")
print(df.info())

# Summary statistics for all numeric columns.
print("\n--- Descriptive Statistics ---")
print(df.describe())

# -----------------------------------------------------------------------------
# 3. MISSING-VALUE AUDIT
# -----------------------------------------------------------------------------
# Count nulls per column to decide on a handling strategy.
print("\n--- Null Count per Column ---")
print(df.isnull().sum())

# Inspect the rows where 'quantity' is null before deciding to drop or impute.
print("\n--- Rows with Null 'quantity' ---")
print(df[df["quantity"].isnull()])

# Narrow to the columns most relevant for diagnosing why quantity is missing.
print("\n--- Category / Profit Margin / Payment for Null-Quantity Rows ---")
print(df[df["quantity"].isnull()][["category", "profit_margin", "payment_method"]])

# -----------------------------------------------------------------------------
# 4. DATA CLEANING
# -----------------------------------------------------------------------------

# 4a. Strip leading/trailing whitespace from all string columns to prevent
#     silent mismatches during grouping and filtering.
df = df.apply(lambda col: col.str.strip() if col.dtype == "object" else col)

# 4b. Remove exact duplicate rows in-place.
df.drop_duplicates(inplace=True)
print("\n--- Duplicate Rows Remaining ---")
print(df.duplicated().sum())  # Expected: 0

# 4c. Drop rows that still contain any null values after the audit above.
#     (For production code, consider targeted imputation per column instead.)
df.dropna(inplace=True)
print("\n--- Shape After Dropping Nulls ---")
print(df.shape)

# Verify the cleaned frame: no nulls, correct dtypes.
print("\n--- Post-Cleaning Info ---")
print(df.info())

# 4d. Normalise column names — strip any accidental whitespace.
df.columns = df.columns.str.strip()

# -----------------------------------------------------------------------------
# 5. TYPE CONVERSION
# -----------------------------------------------------------------------------

# 5a. Remove the dollar sign from 'unit_price' and cast to float so arithmetic
#     operations work correctly.
df["unit_price"] = df["unit_price"].str.replace("$", "", regex=False).astype(float)

# 5b. Parse 'date' as a proper datetime object to enable time-series analysis.
df["date"] = pd.to_datetime(df["date"])

# 5c. Parse 'time' and retain only the time component (HH:MM:SS).
df["time"] = pd.to_datetime(df["time"], format="mixed").dt.time

# -----------------------------------------------------------------------------
# 6. FEATURE ENGINEERING
# -----------------------------------------------------------------------------

# Derive the transaction total from quantity and unit price.
# This recreates or validates any pre-existing 'total' column in the raw data.
df["total"] = df["quantity"] * df["unit_price"]

# -----------------------------------------------------------------------------
# 7. FINAL VERIFICATION
# -----------------------------------------------------------------------------
print("\n--- Final Data Types ---")
print(df.dtypes)

print("\n--- Cleaned Dataset Preview ---")
print(df.head())

df.to_csv("cleaned_walmart_data.csv",index=False)