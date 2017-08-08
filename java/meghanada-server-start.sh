#!/usr/bin/env sh

# start meghanada server
java -ea \
     -XX:+TieredCompilation \
     -XX:+UseConcMarkSweepGC \
     -XX:SoftRefLRUPolicyMSPerMB=50 \
     -Xverify:none \
     -Xms256m -Xmx2G \
     -Dfile.encoding=UTF-8 \
     -jar /opt/java-lib/meghanada/meghanada-0.2.4.jar \
     -p 55555 \
     -v
