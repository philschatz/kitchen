#!/bin/bash
set -x

if [[ ! -d ../../openstax/cnxml ]]; then
    echo "Expect github.com/openstax/cnxml to be checked out at ../../openstax/cnxml/"
    exit 111
fi

xsltproc --output ./autogenerated-schema.rng ./to-schema.xsl ./recipe-config.xml
java -jar ../../openstax/cnxml/cnxml/jing.jar ./autogenerated-schema.rng ./test-module.cnxml