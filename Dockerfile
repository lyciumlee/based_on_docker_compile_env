from ubuntu:18.04
run rm /etc/dpkg/dpkg.cfg.d/excludes && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list
run dpkg --add-architecture i386 && apt update && apt full-upgrade -y && apt clean
run apt install -y locales && apt clean && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
env LC_ALL en_US.UTF-8
env LANG en_US.UTF-8
env LANGUAGE en_US.UTF-8
run DEBIAN_FRONTEND=noninteractive \
    apt install -y git sudo bash make nano vim zsh tmux cmake binutils nasm gcc gdb g++ gcc-multilib g++-multilib \
    build-essential libc6-dev-i386 libc6-dbg libc6-dbg:i386 libstdc++6:i386 \
    python3 python3-pip curl netcat htop iotop iftop man strace ltrace wget \
    manpages-posix manpages-posix-dev libgmp3-dev libmpfr-dev libmpc-dev \
    nmap zmap libssl-dev inetutils-ping dnsutils whois mtr net-tools iproute2 tzdata ruby \
    ssh autoconf automake autopoint bison gettext gperf texinfo rsync \
    && apt-get source libc6-dev \
    && apt clean
run useradd lll && \
    usermod -aG sudo lll && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
user lll
workdir /home/lll