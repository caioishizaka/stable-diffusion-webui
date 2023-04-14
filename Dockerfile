# syntax=docker/dockerfile:1
FROM nvidia/cuda:12.1.0-base-ubuntu22.04 as base

WORKDIR /app

# RUN sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*

COPY . .

ADD https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate-inpainting.safetensors models/Stable-diffusion/Deliberate.safetensors

RUN pip3 install --upgrade pip
RUN pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 --extra-index-url https://download.pytorch.org/whl/cu117
RUN pip install --pre xformers
RUN pip install --pre triton
RUN pip install numexpr

EXPOSE 7860

CMD python3 launch.py --listen