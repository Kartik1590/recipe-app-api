FROM python:3.9-alpine3.13
LABEL maintainer="kartikeya"
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /temp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# as this file is for production thats why dev is flase but when we use it in development mode docker compose will overwrite it to true as we have made args in docker compose as true
ARG DEV=false  
RUN python -m venv /py && \
/py/bin/pip install --upgrade pip && \
if [ $DEV ="true"]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt; \
fi && \
rm -rf /tmp && \
adduser \
--disabled-password \
--no-create-home \
django-user
ENV PATH="/py/bin:$PATH"
USER django-user
