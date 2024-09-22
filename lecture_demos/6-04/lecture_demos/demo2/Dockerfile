FROM python:3.7.1-alpine
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . ./
RUN adduser -D server
USER server
CMD python snake.py
