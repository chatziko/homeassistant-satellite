FROM python:3.11-slim-bookworm AS base-image

RUN apt-get update \
	&& apt-get install --no-install-recommends -y \
        alsa-utils \
    # Clean-up
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache


#################################################


FROM base-image AS compile-image

RUN apt-get update \
	&& apt-get install --no-install-recommends -y \
        unzip

ADD https://github.com/synesthesiam/homeassistant-satellite/archive/refs/heads/master.zip /tmp
RUN cd /tmp && unzip *.zip && rm *.zip
RUN cd /tmp && mv homeassistant-satellite-* homeassistant-satellite

# build a self-contained venv to make copying easier
RUN python3 -m venv /venv

RUN /venv/bin/pip3 --no-cache-dir install \
        /tmp/homeassistant-satellite[silerovad,webrtc]

# copy the sounds
RUN cp -r /tmp/homeassistant-satellite/sounds /venv


###############################################


FROM base-image AS build-image

COPY --from=compile-image /venv /venv

# Copy statically build ffmpeg, much smaller!
COPY --from=mwader/static-ffmpeg:6.0-1 /ffmpeg /usr/local/bin/
