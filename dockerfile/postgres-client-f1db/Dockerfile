FROM postgres

COPY vimrc /root/.vimrc
COPY psqlrc /root/.psqlrc
COPY data /f1db

RUN apt update && apt install -y vim less

ENTRYPOINT ["/bin/bash"]
