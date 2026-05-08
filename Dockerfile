# ──────────────────────────────────────────────────────────────────────────────
# Dockerfile – Maze Project
#
# Clones the public maze repository and provides a ready-to-run Python
# environment.  The maze repo must be PUBLIC on GitHub before building.
#
# Build:
#   docker build -t maze-app .
#
# Run:
#   docker run --rm maze-app
# ──────────────────────────────────────────────────────────────────────────────

FROM python:3.12-slim

# Install git so we can clone the maze repo during build
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone the maze repository (must be public).
# Replace the URL below with your actual public maze repo URL if different.
RUN git clone https://github.com/spadeguy1-cloud/maze.git .

# If the maze project has Python dependencies, install them
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Default command – run the maze entry point if it exists, otherwise list files
CMD ["sh", "-c", "if [ -f main.py ]; then python main.py; else ls -la; fi"]
