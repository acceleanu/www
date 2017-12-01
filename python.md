# Python misc

## [http://docs.python-guide.org/en/latest/dev/virtualenvs]

- pipenv install and simple library usage
```
pip install --user pipenv
mkdir project && cd project
pipenv install BeautifulSoup4
pipenv run python main.py
```

- virtualenv
```
pip install virtualenv
virtualenv project
virtualenv -p /usr/bin/python3 project
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
. project/bin/activate
pip install BeautifulSoup4
deactivate
```

- ipython with pipenv
```
pipenv --three
pipenv install ipython
pipenv run ipython
```

- jupyter notebook
```
mkdir project && cd project
pipenv --three install ipython
pipenv shell
pip install jupyter
pip install matplotlib
jupyter-notebook
```

