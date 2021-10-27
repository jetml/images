FROM tensorflow/tensorflow:2.6.0-jupyter

RUN apt-get update && apt-get install -y \
    dos2unix \
    keychain \
    nano

# Set up our notebook config.

RUN mkdir /root/.jupyter/custom

COPY jupyter_notebook_config.py /root/.jupyter/

COPY custom.css /root/.jupyter/custom/

RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/auth/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/edit/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/notebook/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/terminal/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/tree/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/tree/js/terminallist.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/notebook/js/main.min.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/base/js/namespace.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/static/notebook/js/menubar.js
RUN sed -i 's/_blank/_self/g' /usr/local/lib/python3.6/dist-packages/notebook/templates/notebook.html

RUN mkdir /notebooks

WORKDIR "/notebooks"

COPY run_jupyter.sh /

RUN chmod +x /run_jupyter.sh

RUN dos2unix /run_jupyter.sh

CMD ["/run_jupyter.sh", "--allow-root"]