# README

This is the Rails application powering the African Poetry Digital Portal.

## Precompile Assets
For production this app runs at the `/admin` sub-uri of the frontend app,
so assets must be compiled with:

```bash
RAILS_RELATIVE_URL_ROOT="/admin" RAILS_ENV=production rails assets:precompile
```

## In the News Development Notes

### Elasticsearch

This app uses a mysql database and Elasticsearch for the In the News portion of the site.

Use rake tasks to manage the Elasticsearch index, which should be updated periodically to add the latest database information.

For production, remember to include `RAILS_ENV=production SECRET_KEY_BASE=inconsequential` before the commands.

Clear "in the news" section (should not affect Contemporary African Poetics):

```
rake african_poetics:index_clear
```

Reindex / update existing entries:

```
rake african_poetics:index
```

### Note about Controllers

In order to gain access to methods in the default Orchid ItemsController, in the news controllers inherit as follows:

`class InthenewsworksController < ItemsController`

### Helpers for database / elasticsearch functionality

The database is using standard integer / primary key IDs, while Elasticsearch loosely follows CDRH naming conventions. Conversions look like:

- commentary 1 -> ap.commentary.1
- event 1 -> ap.event.1
- news item 1 -> ap.news.1
- person 1 -> ap.person.1  *
- work 1 -> ap.work.1

\* this differs slightly from the CAP entries in order to avoid overriding (ap.per.00001)

Here are some methods you may find helpful:

`get_es_item(id)`

Returns an elasticsearch item. Possibly of use in the #show actions

`def es_to_db_record(model, es_id)`

Available in inthenews inheriting controllers and views. Takes elasticsearch id and returns an active record object. For example:

`es_to_db_record("Event", "ap.event.158")`
