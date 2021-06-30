# T-app/Circulate - A mini Twitter

It's a 'social blogging' web application similar to Twitter. Users can create accounts, make posts, follow users and comment on posts. You can *circualate* your thoughts and ideas :-)

The application uses Python and Flask for the backend.

## Running locally

- Install PostgreSQL (tested with 9.6.5)
- Install Python (tested with Python 3.6.2)
- Fork or clone this repository
- Create and activate a virtual environment
- Enter the following commands:

```
Create database in Postgresql with name circulate
Run databse as docker container: `sudo docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_DB=circulate  -p 5432:5432 -d postgres`
python -m pip install --upgrade pip setuptools wheel
pip install -r requirements/dev.txt
python manage.py deploy
python manage.py runserver
```

You can now test the app locally with the Flask development server.

## Tests

The app runs various tests:

- unit tests for database models (using unittest)
- unit tests for client view functions (using Flask Test Client)
- unit tests for the API (using Flask Test Client)

It uses [unittest-xml-reporting](https://github.com/xmlrunner/unittest-xml-reporting) for JUNIT style report generation.

See the `tests` directory for details.

`python manage.py test` to run the tests locally.

---
