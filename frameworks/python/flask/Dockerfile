FROM python

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY requirements.txt server.py ./

CMD gunicorn -w 17 --chdir /usr/src/app --bind 0.0.0.0:8006 server:app
