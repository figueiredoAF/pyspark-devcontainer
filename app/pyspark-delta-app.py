import pyspark
from delta import *

builder = pyspark.sql.SparkSession.builder.appName("MyDeltaApp") \
    .config('spark.master','local[*]') \
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
    
    

spark = configure_spark_with_delta_pip(builder).getOrCreate()

print("##########################################################################")
print(f"START MY PYSPARK APP - SPARK VERSION: {spark.sparkContext.version}")
print("##########################################################################")

# Create a table
print("##########################################################################")
print("CREATE TABLE")
print("##########################################################################")
data = spark.range(0, 5)
data.write.format("delta").save("/tmp/delta-table")

# Read a table
print("##########################################################################")
print("READ TABLE")
print("##########################################################################")
df = spark.read.format("delta").load("/tmp/delta-table")
df.show()

print("##########################################################################")
print(f"STOPPING MY PYSPARK APP")
print("##########################################################################")