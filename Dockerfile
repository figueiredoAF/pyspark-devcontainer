FROM gcr.io/spark-operator/spark-py:v3.1.1

ARG SPARK_UID=185
ARG USER_UID=1000
ARG USER_NAME=spark

USER root
ENV PATH="$PATH:/opt/spark/bin/"

# Spark default entrypoint
ENTRYPOINT [ "/opt/entrypoint.sh" ]

RUN 

RUN groupadd -g ${USER_UID} ${USER_NAME} && \
    useradd -u ${USER_UID} -g ${USER_UID} -d /opt/spark/ ${USER_NAME} && \
    usermod -aG root ${USER_NAME} && chmod -R 774 /opt/spark/

# Extra packages
COPY ./jars/delta-core_2.12-1.0.1.jar /opt/spark/jars/
RUN pip install delta-spark==1.0.1

# Specify the User that the actual main process will run as
USER ${USER_NAME}

# Expose spark ui port
EXPOSE 4040