Solr on Docker
==============
A **Dockerfile** for running [Solr](http://lucene.apache.org/solr/) on [Docker](http://www.docker.com).

### Quick Start<a name="quickstart"></a>
A new Solr server can be started from within a directory containing Solr core configuration files using 
the following command:

	  docker run -d -p <host-port>:8983 -v $(pwd):/var/lib/solr/$(basename $(pwd)) infotechsoft/solr

You may then access the Solr server as usual using the docker host's ip address and the specified host port. The Solr logs can be viewed using the standard `docker logs <container>` command.

### Usage
The container runs Solr within a Jetty server and exposes it on port `8983`. It is configured to load cores from 
directories placed in `/var/lib/solr`, which is exposed as a volume. Logging is sent to the console so it may be 
monitored using `docker logs`, and also written to a file on the exposed volume `/var/log/solr` for access by 
tools. The container only contains the Solr libraries necessary for the web application, any other libraries 
required by cores must be provided by the user.

Basic usage of the container for development should follow the [Quick Start](#quickstart) instructions. In order
to build an image for hosting an index, a new `Buildfile` should be created from this one, which adds the 
files required for the application cores. For example:

    FROM infotechsoft/solr:<solr-version>
    
    COPY /cores/lib $SOLR_HOME/lib
    COPY /cores/core1 $SOLR_HOME/core1
    COPY /cores/core2 $SOLR_HOME/core2

Once built, the new image may be started using:

    docker run -d -p <host-port>:8983 <built-image>

Utility containers can access the data for the cores and the logs using the exposed volumes.

### Building

You can build the image yourself from within the **Dockerfile** directory using:
	
	  docker build -t itsdocker.dev/solr:<tag> .

