# Anthelion Data Science Model Development

## Getting started
### Anthelion Tech Stack
Get familiar with the tools and technologies we use at Anthelion.
- [Microsoft Azure](https://azure.com/): go to [azure portal](https://portal.azure.com/#home) to access anthelion resources.
- [OpenAI on Azure](https://azure.microsoft.com/en-us/products/ai-services/openai-service): go to azure portal for azure managed openai resources.
- [AI Foundry](https://portal.azure.com/#browse/Microsoft.MachineLearningServices%2Faistudio): Other AI Services on Azure
  - Deepseek
  - TimeGPT
- [Haystack](https://haystack.deepset.ai/) Open Source AI Framework for LLM Pipeline
- [DataHub](https://datahubproject.io/) Data Catalog to see and track data from all sources
- [Snowflake](https://www.snowflake.com/): data feed from vendors, and processed structured data tables
- [Azure Blob Storage](https://portal.azure.com/#home): storage for large amount of unstructured data
- [Microsoft Fabric](https://app.fabric.microsoft.com/): data warehouse and data pipelines for data science projects at research stage
- [dbt](https://www.getdbt.com/): data transformation tool
- [Feast](https://docs.feast.dev/): feature store. # todo: add instruction to use
- [git](https://git-scm.com/): version control
- [dvc](https://dvc.org/): data version control, model version control, data science pipeline management, experiment tracking, and model registry. # todo: add instruction to use
- [mlflow](https://mlflow.org/): # todo: add instruction to link
- [mkdocs](https://www.mkdocs.org/): documentation tool for code, repos, and ml experiments. Specifically, we use [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) for better UI/UX. And it will be hosted in [Github Pages](https://pages.github.com/)
- [poetry](https://python-poetry.org/): python package management
- [Azure ML](https://learn.microsoft.com/en-us/azure/machine-learning/?view=azureml-api-2): Azure Machine Learning Service, mainly used for model deployment and service endpoint
- Other
  - [Docker](https://www.docker.com/): containerization
  - [Kubernetes](https://kubernetes.io/): container orchestration
  - [Qdrant](https://qdrant.tech/): vector search engine
  - [Github Actions](https://github.com/features/actions): CI/CD



### Start a new project
To make sure we have consistent project structures, we use the [Cookiecutter Data Science](https://cookiecutter-data-science.drivendata.org/) service with customized template. See below for more details on ccds.

[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/cookiecutter-data-science)](https://pypi.org/project/cookiecutter-data-science/)
<a target="_blank" href="https://cookiecutter-data-science.drivendata.org/">
    <img src="https://img.shields.io/badge/CCDS-Project%20template-328F97?logo=cookiecutter" />
</a> 


Before setting up a new project, make sure you have the `ccds` command-line program installed in the base environment (rather than project environment). If you don't have it installed, you can install it in the base environment using the following command:
```bash
pip install cookiecutter-data-science
```
After installing the `ccds` command-line program, you can start a new project by running the following command (adding the anthelion git repo url and -c master - in addition to just ccds - to ensure you are using Anthelion defined structure v.s. the default structure):
```bash
ccds https://gitblabla -c master  # todo: add git repo url
```
Then make sure you initiate git control and dvc control for the project:
```bash
git init
dvc init
```
A pyproject.toml file will be created in the project root directory - see [template structure]({{ cookiecutter.repo_name }}/README.md). You can install the required packages using the following command:   # todo: change to github url
```bash
poetry install
```

### Work on existing project
If you are working on an existing project, you can clone the project from the git repository and navigate to the project directory. Then, you can install the required packages using the following command:
```bash
git clone https://gitblabla  # todo: add git repo url
```
Setup the project environment with the given pyproject.toml file:
```bash
poetry install
```


## Project Structure
Adhere to the template project structure to ensure consistency across projects.
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
│                         `1.0-20240101-initial-data-exploration.ipynb`.
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

## Development
Using Git and DVC for version control and experiment tracking. The main branch should always be the best performing version, while the branches will be each experiment version.

When you start a new experiment, create a new branch from the main branch (or the branch you want to base it on). After the experiment is done, merge the branch to the main branch - if it outperforms. And document the details in the `/docs/experiments` folder accordingly.

For modeling, feel free to start with notebooks (save them in the `notebooks` folder). Naming convention is a number (for ordering), date, and a short `-` delimited description, e.g.`1.0-20240101-initial-data-exploration.ipynb`

If there are reusable code, then move them to the `src` folder's subfolders accordingly.

Once you have a pipeline developed in `src`, you can use `dvc` to manage, rerun, tune, and reproduce the pipeline. The pipeline stages are defined in the `dvc.yaml` file, and the parameters are defined in the `params.yaml` file.

## Documentation
Document your code and experiments to ensure reproducibility and knowledge sharing. Use the [mkdocs](https://www.mkdocs.org/) tool to create documentation for code, repos, and ml experiments. Specifically, we use [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) for better UI/UX. And it will be hosted in [Github Pages](https://pages.github.com/).

Detailed requirements and instructions can be found in the [docs]({{ cookiecutter.repo_name }}/docs/mkdocs/docs) folder. # todo: change to github url