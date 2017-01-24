FROM fliem/tracula_base:fs6

RUN sudo apt-get update && apt-get install -y python3
RUN sudo apt-get update && apt-get install -y python3-pip
RUN pip3 install pybids pandas ipython

RUN apt-get install -y tree htop
RUN apt-get install -y tcsh
RUN apt-get install -y bc
RUN apt-get install -y tar libgomp1 perl-modules

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g bids-validator@0.19.8


RUN mkdir /scratch
RUN mkdir /local-scratch

RUN mkdir -p /code
COPY run.py /code/run.py
COPY tracula.py /code/tracula.py
RUN chmod +x /code/run.py

COPY version /version

ENTRYPOINT ["/code/run.py"]
