FROM maven:3.5-jdk-8-alpine
ENV HOME /home/jenkins
ARG AGENT_WORKDIR=/home/jenkins/agent
COPY slave.jar /usr/share/jenkins/slave.jar
COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN groupadd -g 1000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 1000 -g 1000 -m jenkins
RUN chmod 755 /usr/share/jenkins
RUN chmod 644 /usr/share/jenkins/slave.jar 
USER jenkins
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/jenkins/.jenkins && mkdir -p ${AGENT_WORKDIR}
VOLUME /home/jenkins/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/jenkins
ENTRYPOINT ["jenkins-slave"]
