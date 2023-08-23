# Use the official Ubuntu 22.04 base image
FROM jenkins/ssh-agent:latest as builder

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package index, install necessary packages, and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
    wget unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download the chromedriver zip and chrome-stable-version files and save it to /home
RUN wget -q "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5845.96/linux64/chromedriver-linux64.zip" -O /home/chromedriver.zip 

# Unzip the chromedriver zip file to /home/
RUN unzip /home/chromedriver.zip -d /home/ && \
    chmod 777 /home/chromedriver-linux64/chromedriver && \
    rm /home/chromedriver.zip


# Second stage - Final image
FROM jenkins/ssh-agent:latest

# Copy the chromedriver binary from the builder stage to the final stage
COPY --from=builder /home/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver

# Install pip3 wget and gnupg2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
    wget python3-pip wget gnupg2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

# Install chrome browser
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \ 
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get -y --no-install-recommends install google-chrome-stable

#Install senlenium and webdriver
RUN pip install selenium  \
    pip install webdriver-manager

ADD ./seleniumpy.py /home/jenkins

#RUN    echo "alias python=python3" >> ~/.bashrc

#CMD [ "/bin/bash" ]

