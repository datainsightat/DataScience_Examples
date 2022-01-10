# Batch Data Pipeline

Pipelines process a certain amount of data an then exits.

## EL, ELT

* EL: Data is clean and correct. REST API call.
* ELT: Transform data on the fly. Transformation is not clear at the moment. Transformation can be expressed as SQL. 

### Quality Considerations

* Valid
* Accourate
* Complete
* Consistent
* Uniform
<a/>

### Quality Operations BigQuery

#### Filter to identify and isolate invalid data

![Filter invalid data](../../img/gcp_batchdata_1.md)

#### Duplicates

![Duplicates](../../img/gcp_batchdata_2.md)

#### Accuracy

![Accuracy](../../img/gcp_batchdata_3.md)

#### Completeness

![Completeness](../../img/gcp_batchdata_4.md)

#### Missing

![Missing](../../img/gcp_batchdata_5.md)

#### Uniform

![Uniform](../../img/gcp_batchdata_6.md)

## ETL

Tranformation cannot be expressed in SQL. Use Dataflow as ETL Tool and land data in BigQuery.

### Architecture

* Extract data from
** Pub/Sub
** Cloud Storage
** Cluod Spanner
** Cloud SQL
* Transform Data using Dataflow
* Write Data to BigQuery
<a/>

![ETL Tools](../../img/gcp_batchdata_7.md)

* Dataflow
* Dataproc
* Cloud Data Fusion
<a/>

### Quality Data Operations

Look Beyond Dataflow and BigQuery

|Issue|Solution|
|-|-|
|Latency|Dataflow to Bigtable|
|Spark|Dataproc|
|Visual|Cloud Data Fusion|

#### Dataproc

![Dataproc](../../img/gcp_batchdata_8.md)

#### Cloud Data Fusion

![Cloud Data Fusion](../../img/gcp_batchdata_9.md)

### Data Catalog

Metadata as a service.

* Data Lineage
* Meta Data

![Labels](../../img/gcp_batchdata_10.md)

* Simplify data discovery
* Unified view
* Data governance
<a/>