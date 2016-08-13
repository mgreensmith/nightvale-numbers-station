FROM alpine

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --update ezstream@testing bash

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY next_playlist_item.sh /next_playlist_item.sh
COPY stream.xml /stream.xml

CMD ["/bin/bash"]