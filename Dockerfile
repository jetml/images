FROM tensorflow/tensorflow:2.12.0-jupyter

RUN apt-get update && apt-get install -y \
    dos2unix \
    keychain \
    nano \
    r-base \
    r-base-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

RUN /usr/bin/python3 -m pip install --upgrade pip

RUN pip install opencv-python pandas plotly scikit-learn scipy seaborn torch torchvision torchaudio

# Install R packages and IRkernel
RUN R -e "install.packages(c('devtools', 'IRkernel'), repos = 'https://cloud.r-project.org/')"
RUN R -e "IRkernel::installspec(user = FALSE)"

# Set up our notebook config.
RUN mkdir /root/.jupyter/custom

COPY jupyter_notebook_config.py /root/.jupyter/

COPY custom.css /root/.jupyter/custom/

RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/auth/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/edit/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/notebook/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/terminal/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/tree/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/tree/js/terminallist.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/notebook/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/base/js/namespace.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/notebook/js/menubar.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.8/dist-packages/nbclassic/templates/notebook.html
RUN sed -i 's/w.close/\/\/w.close/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/tree/js/main.min.js
RUN sed -i 's/w.close/\/\/w.close/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/tree/js/newnotebook.js
RUN sed -i 's/w.close/\/\/w.close/g' /usr/local/lib/python3.8/dist-packages/nbclassic/static/tree/js/notebooklist.js

RUN mkdir /notebooks

WORKDIR "/notebooks"

COPY run_jupyter.sh /

RUN chmod +x /run_jupyter.sh

RUN dos2unix /run_jupyter.sh

CMD ["/run_jupyter.sh"]