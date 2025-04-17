FROM python:3.10-slim

# Only copy requirements first to leverage caching
COPY requirements.txt /tmp/

# Install dependencies
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Now copy the rest of the code
COPY . /diabetes-python
WORKDIR /diabetes-python

CMD ["python", "./app.py"]
