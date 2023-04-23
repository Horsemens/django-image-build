FROM python:latest
USER root

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
# optional: for bcp and sqlcmd
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN source ~/.bashrc
# optional: for unixODBC development headers
RUN  apt-get install -y unixodbc-dev
# optional: kerberos library for debian-slim distributions
RUN apt-get install -y libgssapi-krb5-2



COPY /src /home/src
COPY entry-point.sh /entry-point.sh
WORKDIR /home/src
RUN pip install -r requirements.txt

ENTRYPOINT [ "/bin/bash" ,"-c", "/entry-point.sh" ]