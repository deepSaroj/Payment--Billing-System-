
FROM tomcat:9.0-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY WebRoot/ /usr/local/tomcat/webapps/ROOT/
COPY src/ /tmp/src/

RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    && find /tmp/src -name '*.java' -print0 | xargs -0 javac \
       -cp /usr/local/tomcat/lib/servlet-api.jar \
       -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    && rm -rf /tmp/src

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["/usr/local/bin/docker-entrypoint.sh"]
