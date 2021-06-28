FROM python:3.8

RUN python -m pip install --upgrade pip setuptools wheel
RUN mkdir -p /var/t-app
COPY ./ /var/t-app
RUN python -m venv /var/t-app/venv
RUN . /var/t-app/venv/bin/activate && pip install -r /var/t-app/requirements/dev.txt
COPY entry_point.sh /
CMD ["/entry_point.sh"]
