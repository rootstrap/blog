# Experimenting with Airflow to Process S3 Files
![](images/airflow.png)

With machine learning, we always need to deal with ETL processing (Extract, Transform, Load) to get data ready for our model. Airflow can help us build ETL pipelines, and visualize the results for each of the tasks in a centralized way.   
In this blog post, we look at some experiments using Airflow to process files from S3, while also highlighting the possibilities and limitations of the tool.


## What is Airflow? 
Airflow is a platform used to programmatically schedule and monitor the workflows of tasks. This workflow is designed as a dependency graph between tasks. 

It is composed by a **scheduler** which sends the tasks  to be executed following the dependencies, and **workers** which execute the tasks. It also provides an **user interface** to visualize pipelines running and monitor progress, see logs, start the workflows manually and others.

**Airflow executors:** Executors are the mechanism by which task instances get run. Airflow has different executors, you can them find [here](https://airflow.apache.org/docs/stable/executor/index.html). The most common ones are:

- SequentialExecutor is the default executor. The asks are executed sequentially.        
- LocalExecutor you can run locally multiple jobs in parallel. LocalExecutor runs the task on the same node as the scheduler.    
- CeleryExecutor **is the most mature option**. It requires Redis or RabbitMQ to queue the tasks.
- KubernetesExecutor was introduced in version 1.10.0. With KubernetesExecutor you can prepare different docker images for your tasks, and it gives you more flexibility.      

Since CeleryExecutor is more mature, experiments have been performed including this executor in the architecture.   

## Airflow Architecture 

So, when using the Celery Executor, these are the componentes of the architecture:  

- A **database**: contains DAG's (workflows) status and task instances.
- Airflow **web server**: a web interface to query the status in the database, monitor and execute DAGs.
- Airflow **scheduler**: sends the tasks to the queues and updates information in the database. 
- A **message broker**: put into the queue the task's commands to be run.
- Airflow **Celery workers**: retrieve the commands from the queue, execute them and update the database.

![Airflow Architecture with Celery Executor](https://miro.medium.com/max/2000/1*avBjYUY6ZtfEyTkk7FI8JQ.png)

So, the airflow scheduler uses the celery executor to schedule the tasks. The celery executor enqueues the tasks, and each of the workers takes the queued tasks to bee executed. 

All the componentes are deployed in a Kubernetes cluster. The database might be MySQL or Postgres. The message broker might be RabbitMQ or Redis. 

## DAG 

A [DAG](https://airflow.apache.org/docs/stable/concepts.html) (Directed Acyclic Graph) represents a group of tasks, where might exists dependence between them or not. It is defined as a python script, which represents the DAGs structure (tasks and their dependencies) as code.

Each of the tasks is implemented with an Operator. Different types of operator exist, even you can create your custom operator if needed. The most common Operators are BashOperator (to execute bash actions) and PythonOperator (to execute python scripts/functions). In this blog different examples are provided using some of the [operators available](https://airflow.apache.org/docs/stable/_api/airflow/operators/index.html).  


## Running Airflow locally 

You can run locally the Kubernetes cluster for airflow locally with docker-compose. Download this [repo](https://github.com/puckel/docker-airflow])

This docker-compose runs an airflow architecture composed by:    
	- 1 worker, scheduler       
	- flower (jobs' UI)   
	- redis (as broker)      
	- postgres (database)      

All componentes are docker containers.

**Run with celery executor:**           

```bash
docker-compose -f docker-compose-CeleryExecutor.yml up -d
```

## Basic Operations

**List DAGs:** In the [web interface](http://localhost:8080/admin/) you can list all the loaded DAGs and their state. 

![list_dags](images/list_dags.png)

You can use the command line to check the configured DAGs: 

```bash
	docker exec -ti docker-airflow_scheduler_1 ls dags/
```

**Run Manually** 
In the list view, activate the DAG with the On/Off button. The enter to the DAG and press the Trigger button. 

![trigger_dag](images/trigger_dag.png)

**See logs:**

See the logs for a certain task from the web: 

![view_log](images/view_log.png)

You can also check the logs for the scheduler and the worker from the console:

- scheduler's logs :

```bash
	docker logs -f docker-airflow_scheduler_1
```

- see worker's logs:

```bash
	 docker logs -f docker-airflow_worker_1
```

## Experiments with operators:

### BashOperator

The BashOperator executes a bash command. This example contains 3 bash tasks, which 2 of them can execute in parallel. 
To execute it, activate the tutorial DAG. Enter to the view for the DAG and you will see that the first task of the DAG will be scheduled and then queued to be executed.
 
### S3FileTransformOperator
      
This Operator is used to download a file from a s3 bucket, transform it and upload to another bucket. Therefore, in order to use this operator we need to configure a s3 connection.

In the web interface go to Admin->Connections: set the connection id and type. Add the access key and the secret key as ‘extra’ arguments.

To get the canonical user for s3: 
```bash
	aws s3api list-buckets --query Owner.Ioutput text
```

```python
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.s3_file_transform_operator import S3FileTransformOperator

from datetime import datetime, timedelta


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2020, 9, 7),
    "email": ["mikaela.pisani@rootstrap.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

with DAG("s3_transformer", default_args=default_args, schedule_interval= '@once') as dag:

    t1 = BashOperator(
        task_id='bash_test',
        bash_command='echo "hello, it should work" > s3_conn_test.txt'
    )


    transformer = S3FileTransformOperator(
        task_id='ETL_medical_records',
        description='cleans ETL_medical_records',
        source_s3_key='s3://XXX/YYY/ZZZ.xml',
        dest_s3_key='s3://XXX/YYY/WWW.xml',
        replace=False,
        transform_script='/usr/local/airflow/dags/scripts/transform.py',
        source_aws_conn_id='s3_connection',
        dest_aws_conn_id='s3_connection'
    )

    t1.set_upstream(transformer)
```
Change the parameters source\_s3\_key and dest\_s3\_key in the script, and copy the dag to dags folder.  

```bash
	 docker cp test_s3_file_transform_operator.py  docker-airflow_webserver_1:/usr/local/airflow/dags/
```

Create the script 'transform.py'

```python
	#!/usr/bin/python3
	
	
	import sys
	
	input=sys.argv[1]
	output=sys.argv[2]
	
	print("Starting data transformation...")
	# DO SOMETHING
	print("Completed data transformation!")
```

Copy it to the container: 

```bash
	 docker exec -ti docker-airflow_webserver_1 mkdir /usr/local/airflow/dags/scfipts/ & docker cp transform.py  docker-airflow_webserver_1:/usr/local/airflow/dags/scfipts/
```

In order to run this task, we will need to install some libraries in the containers, and then restart them: 

```bash
	docker exec -ti docker-airflow_worker_1 pip install boto3 boto botocore & docker exec -ti docker-airflow_scheduler_1 pip install boto3 boto botocore & docker exec -ti docker-airflow_webserver_1 pip install boto3 boto botocore
```

Restart the containers:

```bash
	docker restart docker-airflow_worker_1 & docker restart docker-airflow_scheduler_1 & docker restart docker-airflow_webserver_1
```

![](images/s3_connection.png)

It is important that the script that you set in the S3FileTransformOperator starts with **#!/usr/bin/python3 **in the case of python.      

**Problem: if your script needs specific libraries to be installed (for example needs pandas), those are not installed in the worker, so when it executes the task gives you an error. For this problem there is not a clean solution, unless instead of celery you use KubernetesExecutor.**

In case that you are having problems, in order to test the connection you can create a DAG that contains a [S3KeySensor](https://airflow.readthedocs.io/en/stable/_modules/airflow/sensors/s3_key_sensor.html).         


### AWSAthenaOperator

This connector allows you to make a query to Athena's database. You will need to set the s3_connection in the ``aws_conn_id`` parameter. This connection should be defined in the Connections configuration. 

Update the following script with the correct database and the disered query. You need to create a database in [AWS Athena](https://aws.amazon.com/es/athena/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc) to query the S3 files.  

```python 
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.s3_file_transform_operator import S3FileTransformOperator
from airflow.contrib.operators.aws_athena_operator import AWSAthenaOperator

from datetime import datetime, timedelta


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2020, 9, 7),
    "email": ["mikaela.pisani@rootstrap.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

with DAG("query_s3", default_args=default_args, schedule_interval= '@once') as dag:

    t1 = BashOperator(
        task_id='bash_test',
        bash_command='echo "Starting AWSAthenaOperator TEST"'
    )

    run_query = AWSAthenaOperator(
        task_id='run_query',
        database='{DATABASE}',
        query='select {PARAM} FROM "{DATABASE}"."{TABLE}"',
        output_location='s3://s3://XXX/YYY/ZZZ',
        aws_conn_id='s3_connection'
    )

    
    t1.set_upstream(run_query)
```    
Copy the dag to the dags directory and execute it from the web interface. 

**KubernetesPodOperator**

This DAG executes the task into a pod, you have the option to kill the pod once it finishes the execution.  
If you have the following error: 

```bash 
	{pod_launcher.py:84} ERROR - Exception when attempting to create Namespaced Pod.
```
Add **in_cluster=True** in the DAG in order to specify that the pod will run in the same cluster. 

**SubdagOperator**

Creates dynamically a subdag inside the dag. 

```python 
from airflow import DAG

from airflow.operators.subdag_operator import SubDagOperator
from airflow.operators.bash_operator import BashOperator
from airflow.hooks.S3_hook import S3Hook
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator

from datetime import datetime, timedelta


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2020, 9, 7),
    "email": ["mikaela.pisani@rootstrap.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

def hello(file):
    print('Hello!!!! ', file)


def loop_files(parent_dag_name, child_dag_name, args):
    dag_subdag = DAG(
        dag_id='{0}.{1}'.format(parent_dag_name, child_dag_name),
        default_args=args,
        schedule_interval="@once",
    )
    
    tasks = []
    for i in range (5):
        tasks = tasks + [PythonOperator(
            task_id='hello_world' + str(i),
            op_kwargs={'file': str(i)},
            python_callable=hello,
            dag=dag_subdag)]


    return dag_subdag
            


dag = DAG("subdagtest2", default_args=default_args, schedule_interval= '@once')

start_op = BashOperator(
    task_id='bash_test',
    bash_command='echo "Starting TEST"',
    dag=dag )

loop_files = SubDagOperator(
    task_id='loop_files',
    subdag=loop_files('subdagtest2', 'loop_files', default_args),dag=dag
)


start_op >> loop_files
```

When you run it it, from the web it appears the option to enter to the subdag's information and logs:
![](images/subdag_operator.png)

This example lists the files in a s3 bucket and for each file creates a subdag "hellow_wold_X". 

![](images/subdags.png)

**Problem: too many tasks are queued, and it is probable that you will need to add more workers.**


# Lessons learned
- When you don't need specific dependencies, use BashOperator or PythonOperator
- When your tasks need specific dependencies, use KubernetesOperator    
- Subdags are useful when you need to repeat a serie of tasks for each S3 file, but you need to be careful to control the size of the queue. 