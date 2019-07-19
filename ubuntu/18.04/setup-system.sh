echo 'initiating sudo ;-)'
sudo ls
export CC=gcc
sudo 	apt-get update && \
sudo	apt-get upgrade -y && \
sudo	apt-get install -y \
	vim-gtk \
	dconf-editor
	autoconf \
	autoconf-archive \
	automake \
	autotools-dev \
	bison \
	clang \
	clang-tools \
	curl \
	default-jdk \
	default-jre \
	faketime libdbd-mysql \
	flex \
	gcc \
	gcc-8 \
	gdb \
	git \
	libbson-dev \
	libcurl4-gnutls-dev \
	libdbi-dev \
	libgcrypt11-dev \
	libglib2.0-dev \
	libgnutls28-dev \
	libgrok1 libgrok-dev \
	libhiredis-dev \
	libkrb5-dev \
	liblz4-dev \
	libmaxminddb-dev libmongoc-dev \
	libmongoc-dev \
	libmysqlclient-dev \
	libnet1-dev \
	libpcap-dev \
	librabbitmq-dev \
	libsnmp-dev \
	libssl-dev libsasl2-dev \
	libsystemd-dev \
	libtokyocabinet-dev \
	libtool \
	libtool-bin \
	logrotate \
	lsof \
	make \
	mysql-server \
	net-tools \
	pkg-config \
	postgresql-client libpq-dev \
	python-docutils  \
	python-pip \
	software-properties-common \
	sudo \
	uuid-dev \
	valgrind \
	vim \
	wget \
	zlib1g-dev

mkdir ~/proj
cd ~/proj
rm -rf codestyle libksi librdkafka
# code style checker - not yet packaged
git clone https://github.com/rsyslog/codestyle
cd codestyle
gcc --std=c99 stylecheck.c -o stylecheck
sudo mv stylecheck /usr/bin/rsyslog_stylecheck
cd ..

# we need Guardtime libksi here, otherwise we cannot check the KSI component
git clone https://github.com/guardtime/libksi.git
cd libksi
autoreconf -fvi
./configure --prefix=/usr
make -j2
sudo make install
cd ..

# NOTE: we do NOT install coverity, because
# - it is pretty large
# - seldomly used
# - quickly installed when required (no build process)

# we need the latest librdkafka as there as always required updates
git clone https://github.com/edenhill/librdkafka
cd librdkafka
(unset CFLAGS; ./configure --prefix=/usr --CFLAGS="-g" ; make -j2)
sudo make install
cd ..
# Note: we do NOT delete the source as we may need it to
# uninstall (in case the user wants to go back to system-default)

# finished installing helpers from source
cd ..

echo use dconf-editor to disable screen saver!
