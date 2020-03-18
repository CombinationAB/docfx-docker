ARG MONO_VERSION=6.8.0.96
ARG DOCFX_VERSION=2.50

FROM mono:${MONO_VERSION}
ARG DOCFX_VERSION
ENV DOCFX_VERSION=${DOCFX_VERSION}
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/dotnet/docfx/releases/download/v${DOCFX_VERSION}/docfx.zip" -o /docfx.zip \
 && mkdir -p /usr/share/docfx \
 && unzip /docfx.zip -d /usr/share/docfx \
 && rm -f /docfx.zip \
 && echo '#!/bin/sh\n\nexec mono /usr/share/docfx/docfx.exe $@' > /usr/bin/docfx \
 && chmod 755 /usr/bin/docfx \
 && docfx --version

ENTRYPOINT docfx

CMD ["-h"]
