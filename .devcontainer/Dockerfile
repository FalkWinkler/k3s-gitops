# You can pick any Debian/Ubuntu-based image. 😊
FROM mcr.microsoft.com/devcontainers/base:bullseye

COPY library-scripts/*.sh /tmp/library-scripts/

ARG KUBECTX_VERSION=0.9.4
ARG K9S_VERSION=0.26.7
ARG GITOPS_VERSION=0.19.0

# [Option] Install zsh
ARG INSTALL_ZSH="false"
# [Option] Upgrade OS packages to their latest versions
ARG upgradePackages="false"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# Enable Backports for age
RUN echo "deb http://deb.debian.org/debian bullseye-backports main" > /etc/apt/sources.list.d/backports.list

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get install -y \
        libssl-dev \
        libffi-dev \
        python3-dev \
        python3-pip \
        age \
        ipcalc \
        jq \
        direnv \
        sshpass \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# kubectx
RUN curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubectx_v${KUBECTX_VERSION}_linux_x86_64.tar.gz" | tar -xz -C /usr/local/bin kubectx \
    # kubens
    && curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubens_v${KUBECTX_VERSION}_linux_x86_64.tar.gz" | tar -xz -C /usr/local/bin kubens \
    # k9s
    && curl -fsSL "https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz" | tar -xz -C /usr/local/bin k9s \
    # gitops
    && curl -fsSL "https://github.com/weaveworks/weave-gitops/releases/download/v${GITOPS_VERSION}/gitops-linux-x86_64.tar.gz" | tar xz -C /usr/local/bin gitops


# Install Ansible
RUN pip3 install ansible[azure]

# [Option] Install Azure CLI
ARG INSTALL_AZURE_CLI="false"
# [Option] Install Docker CLI
ARG INSTALL_DOCKER="true"
# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="lts/*"
ENV NVM_DIR=/usr/local/share/nvm
ENV NVM_SYMLINK_CURRENT=true \
    PATH=${NVM_DIR}/current/bin:${PATH}
RUN if [ "${INSTALL_AZURE_CLI}" = "true" ]; then bash /tmp/library-scripts/azcli-debian.sh; fi \
    && if [ "${NODE_VERSION}" != "none" ]; then bash /tmp/library-scripts/node-debian.sh "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}"; fi \
    && if [ "${INSTALL_DOCKER}" = "true" ]; then \
        bash /tmp/library-scripts/docker-debian.sh "true" "/var/run/docker-host.sock" "/var/run/docker.sock" "${USERNAME}"; \
    else \
        echo '#!/bin/bash\n"$@"' > /usr/local/share/docker-init.sh && chmod +x /usr/local/share/docker-init.sh; \
    fi \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
