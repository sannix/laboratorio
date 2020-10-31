FROM java:jre


ENV PDI_HOME /opt/pentaho-di 
ENV KETTLE_HOME /pentaho-di 
ENV PDI_RELEASE 9.1 
ENV PDI_VERSION 9.1.0.0-324
ENV CARTE_PORT=8181
# ENV CLUSTER_PORT=40000-41000

# RUN curl -L -o /tmp/pdi-ce-${PDI_VERSION}.zip \
#      https://sourceforge.net/projects/pentaho/files/Pentaho%20${PDI_RELEASE}/client-tools/pdi-ce-${PDI_VERSION}.zip/download && \
#    unzip -q /tmp/pdi-ce-${PDI_VERSION}.zip -d $PDI_HOME && \
#    rm /tmp/pdi-ce-${PDI_VERSION}.zip

COPY pdi-ce-${PDI_VERSION}.zip /tmp/

RUN unzip -q /tmp/pdi-ce-${PDI_VERSION}.zip -d $PDI_HOME && \
    rm /tmp/pdi-ce-${PDI_VERSION}.zip

ENV PATH=$PDI_HOME/data-integration:$PATH

EXPOSE ${CARTE_PORT}
# EXPOSE ${CLUSTER_PORT}

RUN mkdir -p $KETTLE_HOME/.kettle /docker-entrypoint.d /templates

COPY carte_config*.xml /templates/

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["carte.sh", "/pentaho-di/carte_config.xml"]