FROM debian

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.cargo/bin:${PATH}"

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl

RUN mkdir -p /src && cd /src && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

COPY tool_interface /src/tool_interface
COPY pyproject.toml /src/pyproject.toml

RUN cd /src && \
    uv venv .venv && \
    . .venv/bin/activate && \
    uv pip install .

WORKDIR /src
RUN uv pip install ipython

CMD ["ipython"]