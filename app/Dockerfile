FROM python:3.11-slim-bookworm AS app
LABEL "website"="https://github.com/mate-dev/mmrelaynode"
RUN groupadd -g 1000 mesh && useradd -ml -u 1000 -g 1000 -s /bin/bash mesh
RUN echo "export PATH=/home/mesh/.local/bin:\$PATH" >> /home/mesh/.bashrc
RUN pip install --upgrade pip -qq
RUN ln -s /home/mesh/.local/bin/meshtastic /bin/meshtastic
USER mesh
COPY --chown=mesh:mesh meshtastic-matrix-relay /home/mesh/app
COPY --chown=mesh:mesh --chmod=744 entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chown=mesh:mesh --chmod=744 wait-for-it.sh /home/mesh/.local/bin/wait-for-it.sh
COPY --chown=mesh:mesh conf_wrapper.py /home/mesh/app/
COPY --chown=mesh:mesh command_wrapper.py /home/mesh/app/
WORKDIR /home/mesh/app
RUN pip install -qq -r /home/mesh/app/requirements.txt --no-cache-dir