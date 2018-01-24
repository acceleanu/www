
- https://blog.sicara.com/get-started-pyspark-jupyter-guide-tutorial-ae2fe84f594f

```
export SPARK_HOME=~/apps/spark
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
export PYSPARK_PYTHON=python3

export PYSPARK_PYTHON=python3 
export PYSPARK_SUBMIT_ARGS="--master local[2]"
export PYSPARK_SUBMIT_ARGS="--master local[*]"
pip install jupyter
pyspark
```

```
import sys, pprint
sys.displayhook = pprint.pprint
locals()
```


- dir() will give you the list of in scope variables:
- globals() will give you a dictionary of global variables
- locals() will give you a dictionary of local variables


