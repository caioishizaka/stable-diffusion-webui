# syntax=docker/dockerfile:1
# FROM ubuntu:22.04 as base
FROM nvidia/cuda:12.1.0-base-ubuntu22.04 as base

WORKDIR /app

COPY . .

# RUN sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
# ADD https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda_12.1.0_530.30.02_linux.run cuda/cuda_12.1.0_530.30.02_linux.run
# COPY ./cuda/cuda_12.1.0_530.30.02_linux.run cuda_12.1.0_530.30.02_linux.run
# RUN cuda_12.1.0_530.30.02_linux.run --silent
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*


# ADD https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate-inpainting.safetensors models/Stable-diffusion/Deliberate.safetensors

RUN pip3 install --upgrade pip
RUN pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 --extra-index-url https://download.pytorch.org/whl/cu117
# RUN pip install --pre xformers
# RUN pip install --pre triton
# RUN pip install numexpr

EXPOSE 7860

CMD python3 launch.py --listen