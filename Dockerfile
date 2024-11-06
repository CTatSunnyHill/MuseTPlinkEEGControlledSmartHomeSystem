# Use Python as the base image
FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    libglib2.0-0 \
    libpugixml1v5 \
    && rm -rf /var/lib/apt/lists/*

# Download and install the LSL binary library
RUN wget https://github.com/sccn/liblsl/releases/download/v1.16.2/liblsl-1.16.2-focal_amd64.deb && \
    dpkg -i liblsl-1.16.2-focal_amd64.deb && \
    rm liblsl-1.16.2-focal_amd64.deb

# Set the working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy everything from the examples folder in the local directory to /app/examples in the container
COPY examples /app/examples
COPY . .
