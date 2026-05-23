#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Apache Maven Wrapper startup batch script, version 3.3.2
# ----------------------------------------------------------------------------

if [ -z "$MAVEN_SKIP_RC" ] ; then
  if [ -f /usr/local/etc/mavenrc ] ; then
    . /usr/local/etc/mavenrc
  fi
  if [ -f /etc/mavenrc ] ; then
    . /etc/mavenrc
  fi
  if [ -f "$HOME/.mavenrc" ] ; then
    . "$HOME/.mavenrc"
  fi
fi

cygwin=false
darwin=false
mingw=false
msys=false
case "$(uname)" in
  CYGWIN*) cygwin=true ;;
  Darwin*) darwin=true ;;
  MINGW*)  mingw=true ;;
  MSYS*)   msys=true ;;
esac

if [ -z "$JAVA_HOME" ] ; then
  javaExecutable="$(which java)"
  if [ -n "$javaExecutable" ] ; then
    readLink=$(which readlink)
    if [ -n "$readLink" ] ; then
      if $darwin ; then
        javaHome="$(dirname "$javaExecutable")"
        javaExecutable="$(readlink "$javaExecutable")"
        javaHome="$(cd "$javaHome" && pwd)"
      else
        javaHome="$(dirname "$(readlink -f "$javaExecutable")")"
      fi
      javaHome="$(expr "$javaHome" : '\(.*\)/bin')"
      JAVA_HOME="$javaHome"
      export JAVA_HOME
    fi
  fi
fi

MAVEN_PROJECTBASEDIR="${MAVEN_BASEDIR:-}"
if [ -z "$MAVEN_PROJECTBASEDIR" ] ; then
  MAVEN_PROJECTBASEDIR="$(pwd)"
  while [ ! -d "$MAVEN_PROJECTBASEDIR/.mvn" ] && [ "$MAVEN_PROJECTBASEDIR" != "/" ] ; do
    MAVEN_PROJECTBASEDIR="$(dirname "$MAVEN_PROJECTBASEDIR")"
  done
fi
export MAVEN_PROJECTBASEDIR

WRAPPER_JAR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar"
WRAPPER_PROPERTIES="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.properties"

if [ -r "$WRAPPER_PROPERTIES" ] ; then
  WRAPPER_URL=$(grep '^wrapperUrl' "$WRAPPER_PROPERTIES" | cut -d'=' -f2)
fi

if [ ! -f "$WRAPPER_JAR" ] ; then
  if command -v wget > /dev/null 2>&1 ; then
    wget -q -O "$WRAPPER_JAR" "$WRAPPER_URL"
  elif command -v curl > /dev/null 2>&1 ; then
    curl -fsSL -o "$WRAPPER_JAR" "$WRAPPER_URL"
  else
    echo "ERROR: neither wget nor curl is available to download maven-wrapper.jar" >&2
    exit 1
  fi
fi

JAVA_CMD="${JAVA_HOME:+$JAVA_HOME/bin/}java"
exec "$JAVA_CMD" $MAVEN_OPTS \
  -classpath "$WRAPPER_JAR" \
  "-Dmaven.multiModuleProjectDirectory=$MAVEN_PROJECTBASEDIR" \
  org.apache.maven.wrapper.MavenWrapperMain "$@"
