import pandas as pd
from sklearn.metrics import accuracy_score, classification_report

def evaluate_performance(model, X_test, y_test):
    """Generates predictions and prints accuracy and classification metrics."""
    y_pred = model.predict(X_test)
    
    print("="*30)
    print("🎯 MODEL PERFORMANCE METRICS")
    print("="*30)
    print(f"Accuracy Score: {accuracy_score(y_test, y_pred) * 100:.2f}%\n")
    print("Classification Report:")
    print(classification_report(y_test, y_pred))

def get_feature_importances(model, feature_names):
    """Returns a DataFrame of the most important predictive features."""
    importances = pd.DataFrame(
        model.feature_importances_,
        index=feature_names,
        columns=['importance']
    ).sort_values('importance', ascending=False)
    
    return importances