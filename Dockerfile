FROM ubuntu:latest

WORKDIR /home
RUN apt update && apt-get install

# install python3.12
RUN apt install -y python3 python3-pip python3-venv python3-tk git build-essential cmake
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# setup virtaul environment
ENV VIRTUAL_ENV="/venv"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV FAB_ROOT=/home
RUN python3 -m venv $VIRTUAL_ENV

# install yosys
RUN apt install -y yosys

#install nextpnr
RUN apt install -y nextpnr-generic

#install ghdl
RUN apt install -y ghdl

# install GTKwave
RUN apt install -y gtkwave

# install icarus
RUN apt install -y iverilog


RUN apt install -y libboost-all-dev
RUN apt install -y libeigen3-dev
RUN git clone -b FABulous-himbaechel https://github.com/KelvinChung2000/nextpnr.git --recursive
WORKDIR /home/nextpnr
RUN mkdir -p build 
WORKDIR /home/nextpnr/build
RUN cmake .. -DARCH="himbaechel;generic" \
             -DUSE_IPO=OFF \
             -DHIMBAECHEL_EXAMPLE_DEVICES=FABulous -DHIMBAECHEL_UARCH=fabulous
RUN make -j$(nproc)
RUN make install
WORKDIR /home/nextpnr/bba
RUN cmake .
RUN make
ENV PATH="/home/nextpnr/bba:$PATH"
WORKDIR /home

RUN git clone https://github.com/KelvinChung2000/HDLGen.git

# install requirements
COPY . /home/FABulous
WORKDIR /home/FABulous
RUN pip install uv
RUN uv sync
RUN uv pip install -e .
    
