import pickle
import pandas as pd

def load_saved_model(filepath='../models/best_model.pkl'):
    """Loads a previously trained model from disk."""
    with open(filepath, 'rb') as f:
        model = pickle.load(f)
    return model

def predict_churn(model, new_customer_data):
    """Makes churn predictions on new data."""
    # Ensure the new data is a DataFrame
    if not isinstance(new_customer_data, pd.DataFrame):
        raise ValueError("Input data must be a pandas DataFrame.")
        
    predictions = model.predict(new_customer_data)
    probabilities = model.predict_proba(new_customer_data)[:, 1] # Probability of churn (Class 1)
    
    return predictions, probabilities