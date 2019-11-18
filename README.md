# README

## Population Data

* Ruby version: 2.4.4

* Rails version: 5.0.1

* Database creation
```
$ bundle exec rake db:create
```

* Database migrations
```
$ bundle exec rake db:migrate
```

* Seed DB
```
$ bundle exec rake seed_zips_data[https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/zip_to_cbsa.csv]

$ bundle exec rake seed_msas_data[https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/cbsa_to_msa.csv]
```

* How to run the test suite
```
bundle exec rails spec
```

* API is hosted on heroku.
To get population data for a given zipcode, make a GET api call to:

https://pop-data.herokuapp.com/zips/:zip

