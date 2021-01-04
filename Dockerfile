# Grab Python image
FROM python
ENV PYTHONUNBUFFERED 1

# Install LibGL for OpenCV to work
# (add other dependencies here too)
RUN apt-get update && apt-get install -y libgl1-mesa-glx

# Upgrade pip
RUN pip install --upgrade pip setuptools

# Define/create a working directory for the RUN/CMD/COPY commands
WORKDIR /app

# Copy the source code from the host to the container into the working directory (/app)
COPY build .

# Install any required dependencies
RUN pip3 install -r requirements.txt

# Tell Docker to listen to traffic on this port inside the container
EXPOSE 4321

# Execute the startup script when the container is run (not necessary)
RUN ["python3", "app.py"]

# Start the Jupyter notebook
CMD jupyter notebook --ip=0.0.0.0 --port=4321 --allow-root --no-browser
