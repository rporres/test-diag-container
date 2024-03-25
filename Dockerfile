FROM registry.access.redhat.com/ubi9/ubi-minimal
ADD root /
RUN chmod 777 /run.sh
ENTRYPOINT ["/run.sh"]
