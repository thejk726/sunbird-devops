#!/bin/bash

SONAR_HOST_URL=${SONAR_HOST_URL}
SONAR_LOGIN=${sonar_token}
PROJECT_PATH=${PWD}
PROJECT_KEY=${JOB_BASE_NAME}
PROJECT_NAME=${JOB_BASE_NAME}

if [ -f "pom.xml" ]; then # Checks and sets parameters for java based projects
  PROJECT_TYPE="java"
  SONAR_SOURCES="src/main/java"
  SONAR_PARAMS="-Dsonar.java.binaries=target.classes"

elif [ -f "package.json" ]; then # Checks and sets parameters for node based projects
  PROJECT_TYPE="node"
  SONAR_SOURCES="."
  SONAR_PARAMS=""

else
  echo "[ ERROR ] Couldn't identify project type!"
  exit 1

fi

echo "Identified project type: ${PROJECT_TYPE}"

docker run\
  --rm \
  -e SONAR_HOST_URL="${SONAR_HOST_URL}" \
  -e SONAR_LOGIN="${SONAR_TOKEN}" \
  -v "${PROJECT_PATH}:/usr/src" \
  sonarsource/sonar-scanner-cli \
  -Dsonar.projectKey="${PROJECT_KEY}" \
  -Dsonar.projectName="${PROJECT_NAME}" \
  -Dsonar.sources="${SONAR_SOURCES}" \
  -Dsonar.login="${SONAR_LOGIN}" \
  ${SONAR_PARAMS}





