# base defines a base stage that uses the official python runtime base image
FROM python:3.11.9-slim AS base
>>>>>>> c4ffea0 (first commit)

# Add curl for healthcheck
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*



RUN groupadd -g 10001 appgroup && \
    useradd -u 10001 -g appgroup -s /bin/sh -m appuser

>>>>>>> c4ffea0 (first commit)
# Set the application directory
WORKDIR /usr/local/app

# Install our requirements.txt
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# dev defines a stage for development, where it'll watch for filesystem changes
FROM base AS dev
RUN pip install watchdog
ENV FLASK_ENV=development

USER appuser
>>>>>>> c4ffea0 (first commit)
CMD ["python", "app.py"]

# final defines the stage that will bundle the application for production
FROM base AS final

# Copy our code from the current folder to the working directory inside the container

COPY --chown=appuser:appgroup . .


USER appuser
# Make port 80 available for links and/or publish
EXPOSE 8080
>>>>>>> c4ffea0 (first commit)

# Define our command to be run when launching the container
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
