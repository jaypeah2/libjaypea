FROM centos:7

# RUN ./scripts/setup-centos7.sh

# cd $(dirname "${BASH_SOURCE[0]}")/../

# openssl req -x509 -nodes -sha256 -newkey rsa:4096 -keyout extras/self-signed-ssl/ssl.key -out extras/self-signed-ssl/ssl.crt

RUN yum -y update

RUN yum -y install epel-release
RUN yum -y install git firewalld fail2ban certbot ntp gperftools psmisc git-lfs
RUN yum -y install clang gcc-c++ libpqxx-devel vim python3 python3-devel
RUN yum -y install libstdc++-static libstdc++ cryptopp cryptopp-devel openssl openssl-devel argon2 libargon2-devel
# RUN yum -y install python3-pip

# RUN pip3 install psutil

# RUN yum -y install postgresql-server postgresql-contrib postgresql-libs postgis

# RUN PGDATA=/data
# RUN	mkdir -p /data


WORKDIR /opt/libjaypea
COPY . /opt/libjaypea

# RUN cp pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
# RUN chown postgres:postgres /var/lib/pgsql/data/pg_hba.conf
# RUN chmod 600 /var/lib/pgsql/data/pg_hba.conf

# RUN postgresql-setup initdb

# # RUN systemctl start postgresql
# RUN /etc/init.d/postgresql start

RUN git clone https://github.com/bwackwat/affable-escapade /opt/affable-escapade




# RUN systemctl enable postgresql
# systemctl restart postgresql

# cp $dir/tables.sql /tables.sql



# RUN chmod 666 tables.sql
# RUN chown postgres:postgres tables.sql

RUN psql -U postgres -c "CREATE DATABASE webservice OWNER postgres;"
RUN psql -U postgres -d webservice -a -f /tables.sql
RUN psql -U postgres -d webservice -c "ALTER ROLE bwackwat PASSWORD '${DB_PASSWORD}';"

EXPOSE 10080
EXPOSE 10443
EXPOSE 11000

# ENTRYPOINT ["./artifacts/jph2"]
CMD ["./artifacts/jph2"]

