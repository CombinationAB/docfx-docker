#!/bin/sh

DOCFX_VERSION=2.50

docker build --build-arg DOCFX_VERSION=$DOCFX_VERSION -t combination/docfx:2.50 .
