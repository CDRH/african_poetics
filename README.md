# README

This is the Rails application powering the African Poetry Digital Portal.

## Precompile Assets

```bash
RAILS_ENV=production rails assets:precompile SECRET_KEY_BASE=anything
```

## In the News Development Notes

### Elasticsearch

This application integrates with Elasticsearch and is populated from https://github.com/CDRH/data_african_poetics and its associated Airtable scripts

### Note about Controllers

In order to gain access to methods in the default Orchid ItemsController, in the news controllers inherit as follows:

`class InthenewsworksController < ItemsController`
