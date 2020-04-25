FROM arm32v7/debian:latest

RUN apt-get update && apt-get upgrade -y && apt-get install debhelper python-all make wget devscripts sudo fakeroot python3-all dh-python gcc-avr arduino-mighty-1284p arduino-mk closure-linter python3-all-dev doxygen doxypy libjs-jquery graphviz python3-serial apache2 git -y

RUN mkdir /build

RUN useradd -ms /bin/bash -g sudo builder
RUN echo 'builder ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo
USER builder
WORKDIR /home/builder

RUN git clone https://github.com/mtu-most/franklin.git

WORKDIR /home/builder/franklin
RUN echo "#!/bin/bash\nmake build && cp /tmp/*.deb /build/" > franklin_build.sh && chmod +x franklin_build.sh
ENTRYPOINT ["./franklin_build.sh"]
# ENTRYPOINT ["/bin/bash"]  # Debug
