FROM ubuntu:22.04

WORKDIR /workspace

RUN apt update \
    && apt install -y curl g++ openjdk-8-jdk python3 unzip zip

RUN curl --proto '=https' --tlsv1.2 -fsSL https://static.pantsbuild.org/setup/get-pants.sh | bash

RUN ln -s /root/.local/bin/pants /bin/pants

WORKDIR /code

COPY bin .

RUN pants

RUN pants generate-lockfiles

RUN pants tailor ::

CMD ["pants", "run", "//src/main:javasources"]