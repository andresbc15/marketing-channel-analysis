def basic_info(df):
    print("This dataset has ", df.shape[1], " columns and ", df.shape[0], " rows.")
    print("This dataset has ", df[df.duplicated()].shape[0], " duplicated rows.")
    print(" ")
    print("Descriptive statistics of the numeric features in the dataset: ")
    print(" ")
    print(df.describe())
    print(" ")
    print("Information about this dataset: ")
    print(" ")
    print(df.info())

import os
import pandas as pd
def load_sql_data(relative_path: str):
    file_path = os.path.abspath(relative_path) 
    if os.path.exists(file_path):
        return pd.read_csv(file_path)
    else:
        print(f'Error: "{file_path}" not found.')

def find_column_inconsistent(df: object):
    # initialize list of inconsistent columns
    problem_columns = []
    # initialize indicator
    flag = True
    # loop through columns
    for column in df.columns:
        # find all data types present
        unique_data_types = df[column].apply(type).unique()   
        # if there is more than one, change flag and print inconsistent column
        if len(unique_data_types) > 1:
            problem_columns.append(column)
            flag = False
            print(f"Column '{column}' has different data types: {unique_data_types}")
            
    if flag:
        print("The values of each column are consistent")
        
def find_categorical_vals(df: object, columns: list):
    # Get unique values for each categorical column
    unique_values = {col: df[col].unique() for col in columns}

    # Print unique values for each categorical column
    for col, values in unique_values.items():
        print(f"Column: {col}")
        print(values)
        print("-----")
        
from itertools import combinations
def primary_key_candidates(dataframe):
    duplicate_counts = {}

    for num_columns in range(2, len(dataframe.columns) + 1):
        for column_combination in combinations(dataframe.columns, num_columns):
            num_duplicates = dataframe.duplicated(subset=column_combination, keep=False).sum()
            duplicate_counts[column_combination] = num_duplicates

    return duplicate_counts
        
import matplotlib.pyplot as plt
def generate_line_graph(dataframe: object, x_val: str, y_val: str, y_unit:str, fill: str, fill_val: list):
    
    # Create a pivot table
    pivot_df = dataframe.pivot(index=x_val, columns=fill, values=y_val)
    
    # Calculate the percentage change over years
    new_col = []
    for content in pivot_df.columns:
        pivot_df[f'{content} Percentage Change'] = pivot_df[content].pct_change() * 100
        new_col.append(f'{content} Percentage Change')

    ax = pivot_df[fill_val].plot(kind='line', marker='o', figsize=(10, 6))
    
    # Add labels
    plt.xlabel(x_val)
    plt.ylabel(f'{y_val} ({y_unit})')
    plt.title(f'Line Graph of {y_val} by {x_val} and {fill}')
    plt.legend(title=fill)
    
    # Annotate with percentage change for each content
    for content in new_col:
        content_name = content.replace(' Percentage Change', '')
        for year, pct_change in pivot_df[content].items():
            ax.annotate(f'{pct_change:.2f}%', (year, pivot_df[content_name][year]),
                        textcoords='offset points', xytext=(0,10), ha='center')

    plt.grid(True)
    plt.show()
    
