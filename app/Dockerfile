FROM python:3.11-slim-bookworm AS app
LABEL "website"="https://github.com/mate-dev/mmrelaynode"
RUN groupadd -g 1000 mesh && useradd -ml -u 1000 -g 1000 -s /bin/bash mesh
RUN pip install --upgrade pip -qq
RUN ln -s /home/mesh/.local/bin/meshtastic /bin/meshtastic
USER mesh
COPY --chown=mesh:mesh meshtastic-matrix-relay /home/mesh/app
COPY --chown=mesh:mesh --chmod=744 wait-for-it.sh /home/mesh/.local/bin/wait-for-it.sh
WORKDIR /home/mesh/app
COPY conf_wrapper.py .
COPY command_wrapper.py .
RUN pip install -qq -r /home/mesh/app/requirements.txt --no-cache-dir
RUN echo "export PATH=/home/mesh/.local/bin:\$PATH" >> /home/mesh/.bashrc