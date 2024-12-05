FROM python:2.7-onbuild

# set a directory for this app
WORKDIR usr/src/app

# copy all the files to the container
COPY . .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# set the port number the container should expose
EXPOSE 5000

# execute the application file (app.py)
CMD [ "python", "app.py" ]