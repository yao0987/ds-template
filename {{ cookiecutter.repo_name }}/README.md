# {{cookiecutter.project_name}}


{{cookiecutter.description}}

## Project Organization

```
├── README.md          <- The top-level README for developers using this project.
├── pyproject.toml     <- python environment setup
├── .env               <- environment variables - ignore in git but required locally
├── .env.sample        <- sample files include instructions for setting up local .env
├── dvc.yaml           <- stages setup for dvc pipeline management
├── params.yaml        <- parameters for dvc pipeline
│
├── data
│   ├── external       <- Data from third party sources.
│   ├── interim        <- Intermediate data that has been transformed.
│   ├── processed      <- The final, canonical data sets for modeling.
│   └── raw            <- The original, immutable data dump.
│
├── docs               <- A default mkdocs project; see www.mkdocs.org for details. 
│                         Documentation for code / repos, Documentation for experiments / runs
│
├── models             <- Trained and serialized models, model predictions, or model summaries
│
├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
│                         date, and a short `-` delimited description, e.g.
│                         `1.0-20240101-initial-data-exploration`.
│
├── pyproject.toml     <- Project configuration file with package metadata for 
│                         {{ cookiecutter.module_name }} and configuration for tools like black
│
├── references         <- Data dictionaries, manuals, and all other explanatory materials.
│
└── src                <- Source code for use in this project.
    │
    ├── __init__.py             <- Makes {{ cookiecutter.module_name }} a Python module
    │
    ├── config.py               <- Store useful variables and configuration
    │
    ├── data                    <- Scripts to download or generate data      
    │   ├── __init__.py 
    │   └── dataset.py        
    │
    ├── eval                    <- Code to evaluate the models
    │   ├── __init__.py 
    │   ├── metrics.py          <- Code to calculate evaluation metrics          
    │   └── backtest.py         <- Backtest module
    │
    ├── features                <- Code to create features for modeling      
    │   ├── __init__.py 
    │   └── features.py        
    │
    ├── report                  <- Code for generating reports
    │   ├── __init__.py 
    │   └── plots.py            <- Code to create visualizations
    │
    ├── train                
    │   ├── __init__.py 
    │   └── train.py            <- Code to train models
    │
    └── predict.py              <- Code to run model inference with trained models          
```

--------

