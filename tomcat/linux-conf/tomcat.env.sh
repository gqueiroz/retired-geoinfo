#!/bin/bash
# Script para ajudar nas configurações de utilização do GeoServer. Este script foi retirado do projeto TerraMA2
# Link do TerraMA2: https://github.com/TerraMA2

# JVM
export JAVA_OPTS="$JAVA_OPTS -server"
export JAVA_OPTS="$JAVA_OPTS -Xms2048m"
export JAVA_OPTS="$JAVA_OPTS -Xmx4096m"
export JAVA_OPTS="$JAVA_OPTS -XX:+UseConcMarkSweepGC"
export JAVA_OPTS="$JAVA_OPTS -XX:NewSize=512m"
export JAVA_OPTS="$JAVA_OPTS -XX:MaxNewSize=1024m"

# Catalina
export CATALINA_OPTS="$CATALINA_OPTS -Duser.timezone=GMT"
