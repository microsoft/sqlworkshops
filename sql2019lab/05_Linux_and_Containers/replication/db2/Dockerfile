FROM mcr.microsoft.com/mssql/server:2019-CTP3.0-ubuntu

COPY . /

RUN chmod +x /db-init.sh
CMD /bin/bash ./entrypoint.sh