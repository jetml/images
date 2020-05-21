FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        dos2unix \
        git \
        python3 \
        python3-dev \
        python3-pip \
        unzip \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip --no-cache-dir install --upgrade \
    pip \
    setuptools

RUN ln -s $(which python3) /usr/local/bin/python

RUN python3 -m pip install --no-cache-dir tensorflow

RUN python3 -m pip install jupyter matplotlib
# Pin ipykernel and nbformat; see https://github.com/ipython/ipykernel/issues/422
RUN python3 -m pip install jupyter_http_over_ws ipykernel==5.1.1 nbformat==4.4.0
RUN jupyter serverextension enable --py jupyter_http_over_ws

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

RUN apt-get autoremove -y && apt-get remove -y wget

EXPOSE 8888

RUN python3 -m ipykernel.kernelspec

#CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/ --ip 0.0.0.0 --no-browser --allow-root"]

RUN mkdir /notebooks

WORKDIR "/notebooks"

COPY run_jupyter.sh /

RUN chmod +x /run_jupyter.sh

RUN dos2unix /run_jupyter.sh

CMD ["/run_jupyter.sh", "--allow-root"]