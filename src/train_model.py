from sklearn.ensemble import RandomForestClassifier
import pickle
import os

def train_random_forest(X_train, y_train):
    """Trains a Random Forest model with balanced class weights."""
    model = RandomForestClassifier(
        n_estimators=100, 
        max_depth=10, 
        random_state=42, 
        class_weight='balanced'
    )
    model.fit(X_train, y_train)
    return model

def save_model(model, filepath='../models/best_model.pkl'):
    """Saves the trained model to disk."""
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    with open(filepath, 'wb') as f:
        pickle.dump(model, f)
    print(f"Model successfully saved to {filepath}")