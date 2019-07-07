FROM mcr.microsoft.com/mssql/rhel/server:2019-CTP3.1
COPY . /

RUN chmod +x /db-init.sh
CMD /bin/bash ./entrypoint.sh