# Data Engineer Exam

[Data Engineer Exam Guide](https://cloud.google.com/certification/guides/data-engineer)  
[Google Cloud Documentation](https://cloud.google.com/docs/overview)

* Data Representation
* Pipelines
* Processing Infrastructure
<a/>

# Data Processing Systems

## Designing and building

### Data Processing Anatomy

![Data Processing Anatomy](../../img/gcp_de_exam_1.jpg)

### A view of data engineering on Google Cloud

![Data Engineering](../../img/gcp_de_exam_2.jpg)  

### Storage and Databases

![Storage and Databases](../../img/gcp_de_exam_3.jpg) 

### Processing

![Processing](../../img/gcp_de_exam_4.jpg)

### Data Processing Services

Combines storage and compute.  

![Services](../../img/gcp_de_exam_5.jpg)

#### Data Abstractions

|Service|Data Abstraction|Compute Abstraction|
|-|-|-|
|Dataproc, Spark|RDD|DAG|
|Bigquery|Table|Query|
|Dataflow|PCollection|Pipeline|

### Artificial Intelligence

![AI](../../img/gcp_de_exam_6.jpg)

### Pre- and Postpcocessing Services

![PrePost Processing](../../img/gcp_de_exam_7.jpg)

### Infrastructure Services

![Infrastructure Services](../../img/gcp_de_exam_8.jpg)

## Design Flexible Data Representations

|Storage|Type|Stored in|
|-|-|-|
|Cloud Storage|Object|Bucket|
|Datastore|Property|Entity > Kind|
|Cloud SQL|Values|Rows and Columns > Table > Database|
|Cloud Spanner|Values|Rows and Columns > Tables > Database|

### Data in Files and Data in Transit

![Data Types](../../img/gcp_de_exam_9.jpg)  

### Standard SQL Data Types

|Data type|Value|
|-|-|
|string|variable-length (unicode) character|
|int64|64-bit integer|
|float64|Double-precision decimal values|
|bool|true or false|
|array|ordered list of zero or more elements|
|struct|container of ordered fields|
|timestamp|represents an absolutej point in time|

### BigQuery Datasets, Tabnles and Jobs

* Project > Users and datasets
  * Limit access to datasets and jobs
  * Manage billing
* Dataset > Tables and views
  * Access Control Lists
  * Applied to all tables in the dataset
* Table > Collection of columns
  * Columnar storage
  * Views are virtual tables
  * Tables can be external
* Job > Potentially long-running action
  * Can be cancelled
<a/>

#### BigQuery is Columnar

![Columnar Storage](../../img/gcp_de_exam_10.jpg)

### Spark hides Complexity in RDDs

RDDs hide complexity and allow making decisions on your behald. Manages: Location, Partition, Replication, Recovery, Pipelining ...

![RDD](../../img/gcp_de_exam_11.jpg)

### Dataflow

#### PCollections

![PCollections](../../img/gcp_de_exam_12.jpg)

* Each step is a transformation
* All transformations are a pipeline
* Runner local, or in cloud
<a/>

* Each step is elastically scaled
* Each Transform is applied on a PCollection
* The result of an apply() is another PCollection
<a/>

#### Batch and stream processing

![Batch and Stream](../../img/gcp_de_exam_13.jpg)  

Bounded va Unbounded data. Dataflow uses windows to use streaming data. PCollections are not compatible with RDDs.

### Tensorflow

Opensource code for machine learning.  

![Tensor](../../img/gcp_de_exam_14.jpg)

## Design Data Pipelines


