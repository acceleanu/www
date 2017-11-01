# Python misc

## [http://docs.python-guide.org/en/latest/dev/virtualenvs]

- pipenv 
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




