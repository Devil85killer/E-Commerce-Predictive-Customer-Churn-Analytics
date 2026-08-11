import pandas as pd
from sklearn.model_selection import train_test_split

def prepare_features_and_target(df):
    """Separates features (X) and target (y), and handles missing values."""
    # Drop the unique identifier as it has no predictive value
    X = df.drop(columns=['customer_unique_id', 'churn_target'])
    y = df['churn_target']
    
    # Fill any null values with 0
    X = X.fillna(0)
    
    return X, y

def split_data(X, y, test_size=0.2, random_state=42):
    """Splits the data into training and testing sets."""
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=test_size, random_state=random_state, stratify=y
    )
    return X_train, X_test, y_train, y_test