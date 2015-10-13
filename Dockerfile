# Create image for a SOLR container
FROM infotechsoft/java:7-jre

MAINTAINER Ray Bradley "https://github.com/rmbrad"

ENV SOLR_VERSION 4.9.1
ENV SOLR solr-$SOLR_VERSION
ENV SOLR_JETTY /usr/local/$SOLR
ENV SOLR_HOME /var/lib/solr

RUN curl http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz | \
      tar -xz -C /tmp/ --exclude $SOLR/example/example* --exclude $SOLR/example/multicore --exclude $SOLR/example/solr/collection1 --strip-components=1 $SOLR/example && \
    mv /tmp/example $SOLR_JETTY && \
    mv $SOLR_JETTY/solr $SOLR_HOME && \
    mkdir -p /var/log/solr && \
    sed -i 's:^\(solr.log=\).*:\1/var/log/solr/:g' $SOLR_JETTY/resources/log4j.properties && \
    yum clean all


EXPOSE 8983
VOLUME ["$SOLR_HOME", "/var/log/solr"]

WORKDIR $SOLR_JETTY
CMD ["java", "-Dsolr.solr.home=/var/lib/solr", "-jar", "start.jar"]
