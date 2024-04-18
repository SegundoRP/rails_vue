# README  

This repository is an API to get earthquakes of the last 30 days. Therefore there is an interface to check earthquake's features and add a comment about every earthquake that you want.

## Tech Stack

- Earthquake [API](https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson)
- Ruby 3.1.2
- Ruby on Rails 7.1.3
- Vue js 3
- Vuex 4
- Bootstrap 5.3.3
- Vite 5.2
- Vue awesome paginate 1.1.46
- Postgresql 12
- Gems:
  - rack-cors
  - json
  - http
  - jsonapi-serializer
  - will_paginate

## Endpoints 

#### Get all earthquakes

```ruby
  GET /api/features
```

#### Get earthquakes with page, per page and filter settings

```ruby
  GET /api/features?page={page}&per_page={per_page}&mag_type[]={mag_type}
```

|Parameter|Type|Description|
|-----|----|----|
|`page`|`integer`|Required - number of page|
|`per_page`|`integer`|Required - records per page|
|`mag_type`|`array(string)`|Required - filter by mag_type, options: md, ml, ms, mw, me, mi, mb, mlg|

#### Post a comment per earthquake

```ruby
  POST /api/features/:feature_id/comments
```

|Parameter|Type|Description|
|-----|----|----|
|`body`|`text`|Required - content of comment for specific feature(earthquake)|
|`feature_id`|`integer`|Required - id of the feature(earthquake)|


## Setup

1. Clone repo and change to directory repo 

```
git clone git@github.com:SegundoRP/rails_vue.git && cd $_
```

2. Install backend dependencies

```
bundle i
```

3. Create db and run migrations

```
rails db:create db:migrate
```
4. Install frontend dependencies

```
cd client && npm i
```

5. Run task to get earthquakes into db

```
rake earthquakes:get_earthquakes
```

6. Run backend server

```
rails s
```

7. Run frontend server

```
cd client && npm run dev
```
