FROM postgres

COPY vimrc /root/.vimrc
COPY psqlrc /root/.psqlrc

RUN apt update && apt install -y vim less

ENTRYPOINT ["/bin/bash"]
