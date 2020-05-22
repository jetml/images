FROM tensorflow/tensorflow:latest-gpu-jupyter

RUN apt-get update && apt-get install -y \
    dos2unix 

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

RUN mkdir /notebooks

WORKDIR "/notebooks"

COPY run_jupyter.sh /

RUN chmod +x /run_jupyter.sh

RUN dos2unix /run_jupyter.sh

CMD ["/run_jupyter.sh", "--allow-root"]