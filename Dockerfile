ARG MONO_VERSION=6.8.0.96
ARG DOCFX_VERSION=2.50
ARG PLANTUML_VERSION=1.2020.2

FROM mono:${MONO_VERSION}
ARG DOCFX_VERSION
ARG PLANTUML_VERSION

RUN mkdir -p /usr/share/man/man1 \
 && apt-get update \
 && apt-get install --no-install-recommends -y unzip graphviz default-jre-headless gpg curl apt-transport-https \
 && rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/dotnet/docfx/releases/download/v${DOCFX_VERSION}/docfx.zip" -o /docfx.zip \
 && mkdir -p /usr/share/docfx \
 && unzip /docfx.zip -d /usr/share/docfx \
 && rm -f /docfx.zip \
 && echo '#!/bin/sh\n\nexec mono /usr/share/docfx/docfx.exe $@' > /usr/bin/docfx \
 && chmod 755 /usr/bin/docfx \
 && docfx --version

RUN curl -L "http://sourceforge.net/projects/plantuml/files/plantuml.{PLANTUML_VERSION}.jar/download" -o /usr/lib/plantuml.jar

# Install dotnet
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.asc.gpg \
&& curl -o /etc/apt/sources.list.d/microsoft-prod.list https://packages.microsoft.com/config/debian/9/prod.list \
&& apt-get update \
&& apt-get install --no-install-recommends -y dotnet-sdk-3.1 \
&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/bin/docfx" ]

CMD ["-h"]
