FROM gcr.io/spark-operator/spark-py:v3.1.1

ARG spark_uid=185

USER root
ENV PATH="$PATH:/opt/spark/bin/"

# Spark default entrypoint
ENTRYPOINT [ "/opt/entrypoint.sh" ]

# Specify the User that the actual main process will run as
USER ${spark_uid}

# Expose spark ui port
EXPOSE 4040