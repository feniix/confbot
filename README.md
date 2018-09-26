# confbot

## Create api auth token

Login to https://id.atlassian.com/manage/api-tokens and create new auth token.

Then create the token for the authentication:

```bash
echo -n "<USERNAME:<PASSWORD>" | base64
```

## Setup variables

`export CONF_ATLASSIAN_TOKEN=<token>`
`export CONF_ATLASSIAN_QUERY_LIMIT=1000`

## Run the program

```bash

#build the app
shards build

#run the app
./bin/confbot
```