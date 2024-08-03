FROM mcr.microsoft.com/devcontainers/base:jammy as installer

ARG DYALOG_RELEASE=19.0

RUN apt-get update && apt-get install -y curl && \
    apt-get clean && rm -Rf /var/lib/apt/lists/*

RUN DEBFILE=`curl -o - -s https://www.dyalog.com/uploads/php/download.dyalog.com/download.php?file=docker.metafile | awk -v v="$DYALOG_RELEASE" '$0~v && /deb/ {print $3}'` && \
    curl -o /tmp/dyalog.deb ${DEBFILE}

ADD rmfiles.sh /

RUN dpkg -i --ignore-depends=libtinfo5 /tmp/dyalog.deb && /rmfiles.sh


###### SECOND IMAGE SETUP ##########
FROM mcr.microsoft.com/devcontainers/base:jammy

## DEFAULT user is vscode GUI=1000; Create a user for scicloj
ARG DYALOG_RELEASE=19.0
ARG USERNAME=vscode

## Setup Base Docker container configuration
RUN apt-get update && apt-get install -y --no-install-recommends locales && \
    apt-get clean && rm -Rf /var/lib/apt/lists/*             && \
    sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen    && \
    locale-gen

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:UTF-8
ENV LC_ALL en_GB.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends libncurses5 && \
    apt-get clean && rm -Rf /var/lib/apt/lists/*

COPY --from=0 /opt /opt

## Setup Dyalog APL Latest version
RUN P=$(echo ${DYALOG_RELEASE} | sed 's/\.//g') && update-alternatives --install /usr/bin/dyalog dyalog /opt/mdyalog/${DYALOG_RELEASE}/64/unicode/dyalog ${P}
RUN P=$(echo ${DYALOG_RELEASE} | sed 's/\.//g') && update-alternatives --install /usr/bin/dyalogscript dyalogscript /opt/mdyalog/${DYALOG_RELEASE}/64/unicode/scriptbin/dyalogscript ${P}
RUN cp /opt/mdyalog/${DYALOG_RELEASE}/64/unicode/LICENSE /LICENSE

COPY entrypoint /entrypoint

RUN sed -i "s/{{DYALOG_RELEASE}}/${DYALOG_RELEASE}/" /entrypoint

RUN mkdir /app /storage && \
    chmod 777 /app /storage

LABEL org.label-schema.licence="proprietary / non-commercial"   \   
      org.label-schema.licenceURL="https://www.dyalog.com/uploads/documents/Private_Personal_Educational_Licence.pdf"

ENV RIDE_INIT=http:*:8899
### END Dyalog APL setup

# Create scicloj user
# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash -d /home/scicloj \
#     #
#     # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
#     && apt-get update \
#     && apt-get install -y sudo \
#     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************## Setup GNU APL for Clojure Integration

## Now that we have a scicloj user, setup GNU APL and add some Java/R Dependencies
RUN mkdir /home/vscode/scripts \
    && chown vscode:vscode /home/vscode/scripts
    
WORKDIR /home/vscode/scripts
COPY ./setup_apl setup_apl
RUN chmod +x setup_apl \
    && ./setup_apl 

## Install Clojure
RUN curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh \
    && chmod +x linux-install.sh \
    && ./linux-install.sh 

USER $USERNAME
WORKDIR /home/vscode
VOLUME [ "/storage", "/app" ]
ENTRYPOINT ["/entrypoint"]
