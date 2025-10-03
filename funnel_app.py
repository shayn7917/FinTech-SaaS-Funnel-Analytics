import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

# Funnel model function
def funnel_model(signups, activation_rate, conversion_rate, retention_rate, revenue_per_customer):
    activated = signups * activation_rate
    converted = activated * conversion_rate
    retained = converted * retention_rate
    revenue = retained * revenue_per_customer
    
    return signups, activated, converted, retained, revenue

# Streamlit UI
st.title("📊 SaaS Funnel Analytics Dashboard")
st.markdown("Simulate how improvements in funnel stages impact customer retention and revenue.")

# Inputs
signups = st.number_input("Total Signups", min_value=1000, value=10000, step=1000)
activation_rate = st.slider("Activation Rate", 0.0, 1.0, 0.60, 0.01)
conversion_rate = st.slider("Conversion Rate", 0.0, 1.0, 0.30, 0.01)
retention_rate = st.slider("Retention Rate", 0.0, 1.0, 0.70, 0.01)
revenue_per_customer = st.number_input("Revenue per Retained Customer ($)", min_value=1, value=50, step=5)

# Compute funnel
signups, activated, converted, retained, revenue = funnel_model(
    signups, activation_rate, conversion_rate, retention_rate, revenue_per_customer
)

# Show results
st.subheader("🔹 Funnel Summary")
st.write(f"**Signups:** {int(signups)}")
st.write(f"**Activated:** {int(activated)} ({activation_rate*100:.1f}%)")
st.write(f"**Converted:** {int(converted)} ({conversion_rate*100:.1f}%)")
st.write(f"**Retained:** {int(retained)} ({retention_rate*100:.1f}%)")
st.write(f"**Revenue:** ${int(revenue)}")

# Sensitivity Analysis
st.subheader("🔹 Sensitivity Analysis (Revenue Impact of +1% Improvement)")

baseline_rev = revenue
rev_signup = funnel_model(signups + int(signups*0.01), activation_rate, conversion_rate, retention_rate, revenue_per_customer)[4]
rev_activation = funnel_model(signups, activation_rate+0.01, conversion_rate, retention_rate, revenue_per_customer)[4]
rev_conversion = funnel_model(signups, activation_rate, conversion_rate+0.01, retention_rate, revenue_per_customer)[4]
rev_retention = funnel_model(signups, activation_rate, conversion_rate, retention_rate+0.01, revenue_per_customer)[4]

diffs = [0, rev_signup - baseline_rev, rev_activation - baseline_rev, rev_conversion - baseline_rev, rev_retention - baseline_rev]
rows = ["Baseline", "1% Signups ↑", "1% Activation ↑", "1% Conversion ↑", "1% Retention ↑"]

# Plot bar chart
fig, ax = plt.subplots()
ax.bar(rows, diffs)
ax.set_ylabel("Revenue Impact ($)")
ax.set_title("Revenue Impact of 1% Improvement in Funnel Stages")
plt.xticks(rotation=15)

st.pyplot(fig)
