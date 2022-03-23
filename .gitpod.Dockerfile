FROM gitpod/workspace-full

#Install Python Packages
COPY requirements.txt /tmp/
RUN  pip3 install --requirement /tmp/requirements.txt
RUN cat /tmp/requirements.txt | sed -e '/^\s*#.*$/d' -e '/^\s*$/d' | xargs -n 1 pip3 install

# RUN mkdir -p /supervised/notebooks/

# Install Helm and Kubectl
## Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    sudo mv ./kubectl /usr/local/bin/kubectl && \
    mkdir ~/.kube

## Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

#add jupyter
# WORKDIR /supervised/notebooks/
# few inits
RUN pip install --upgrade pip
RUN sudo apt-get install -y protobuf-compiler python-pil python-lxml


RUN pip install --no-cache-dir matplotlib pandas jupyter jupyterlab
# RUN protoc object_detection/protos/*.proto --python_out=.

EXPOSE 8888

ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root"]
# Install tensorflow probability
# RUN pip install jaxlib
