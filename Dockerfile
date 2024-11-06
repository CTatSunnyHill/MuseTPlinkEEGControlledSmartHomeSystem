# Use Python as the base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY . .

RUN pip install -r requirements.txt


# Run both scripts sequentially
CMD python startMuseStream.py && python stream-muse-test.py
