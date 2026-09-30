FROM ubuntu:22.04
ENV ITERATIONS=3
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh
WORKDIR /data
CMD ["/usr/local/bin/script.sh"]
