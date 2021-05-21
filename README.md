# Workouts

Uses selenium to scrape exercise information. Selenium is used because the exercises are lazy loaded, too lazy to try native python solution found online.

Each muscle group has its own json file, with the format:
```
{
  '<muscle group>': [
    {
      'title': <exercise title>,
      'equipment': <exercise equipment>,
      'link': <link to exercise page>,
      'pictures': [<picture links from exercise page>]
    },
    ...
  ]
}
```

Parsing all of the exercises for all of the muscle groups will take a long time.
