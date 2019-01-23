#!/bin/bash

JENKINS_BASE_URL="https://builder.example.com" # REPLACE THIS
AGENT_NAME="agnew" # REPLACE THIS
JENKINS_SECRET="abcd1034238902390230320723073089540984391432731247903890321809" # REPLACE THIS
JENKINS_WORK_DIR="/Users/jenkinsbuilder/remoteroot" # REPLACE THIS


JENKINS_AGENT_JAR_URL="${JENKINS_BASE_URL}/jnlpJars/agent.jar"
JENKINS_JNLP_URL="${JENKINS_BASE_URL}/computer/$AGENT_NAME/slave-agent.jnlp"

# Test if java is really installed, or if it's Apple's silly graphic warning saying it isn't installed.
if java 2>&1 | grep 'No Java runtime present'; then
  echo "You need to install Java."
  exit 1
fi

# Delete agent.jar, if it exists.
if [ -e agent.jar ]; then
  rm agent.jar
fi

# Redownload agent.jar
curl ${JENKINS_AGENT_JAR_URL} -o agent.jar

# Run it!
java -jar agent.jar -jnlpUrl "${JENKINS_JNLP_URL}" -secret "${JENKINS_SECRET}" -workDir "${JENKINS_WORK_DIR}"
