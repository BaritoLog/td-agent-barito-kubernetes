FROM gcr.io/google_containers/ubuntu-slim:0.6

# Ensure there are enough file descriptors for running td-agent.
RUN ulimit -n 100000

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

COPY install.sh /tmp/install.sh
RUN ["chmod", "+x", "/tmp/install.sh"]
RUN /tmp/install.sh

COPY config.sh /tmp/config.sh
RUN ["chmod", "+x", "/tmp/config.sh"]
RUN /tmp/config.sh

COPY config.sh /tmp/cleanup.sh
RUN ["chmod", "+x", "/tmp/cleanup.sh"]
RUN /tmp/cleanup.sh

ENV LD_PRELOAD /opt/td-agent/embedded/lib/libjemalloc.so

# Run the td-agent service.
ENTRYPOINT ["tini", "-v", "--", "watchexec", "-v", "-w", "/etc/td-agent", "-n", "-s", "SIGHUP", "td-agent"]
