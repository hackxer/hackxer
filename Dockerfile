# Use Python 2.7 Slim
FROM python:2.7-slim

# Update Repos\
  && apt-get clean

RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends build-essential sudo git wget curl nmap ruby 
# Install Python dependecies
RUN pip install requests

# Install hackxer https://github.com/hackxer/hackxer
RUN git clone 
  && cd hackxer \
  && chmod +x install.sh \
  && ./install.sh

# Change workdir
WORKDIR /root/.hackxer/

# Hack to keep the container running
CMD python -c "import signal; signal.pause()"
