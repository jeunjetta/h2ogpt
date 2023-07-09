# devel needed for bitsandbytes requirement of libcudart.so, otherwise runtime sufficient
# FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu20.04
FROM graphcore/pytorch:3.3.0-ubuntu-20.04-20230703

#ARG DEBIAN_FRONTEND=noninteractive

ENV CUDA_VISIBLE_DEVICES="-1"
ENV Geographic_area=4

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    software-properties-common \
    pandoc \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt install -y python3.10 python3-dev libpython3.10-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY requirements.txt requirements.txt
#COPY ./reqs_optional/requirements_optional_langchain.txt ./reqs_optional/requirements_optional_langchain.txt
#COPY ./reqs_optional/requirements_optional_gpt4all.txt ./reqs_optional/requirements_optional_gpt4all.txt

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python
RUN python -m pip install -r requirements.txt
#RUN python -m pip install -r reqs_optional/requirements_optional_langchain.txt
#RUN python -m nltk.downloader all  # for supporting unstructured package
#RUN python -m pip install -r reqs_optional/requirements_optional_gpt4all.txt

COPY . .

ENTRYPOINT ["python"]
