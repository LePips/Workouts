# Workouts

Extracts all of the exercises from Bodybuilding.com and creates an app to display them.

### `workouts.py`

With the process of webscraping, it will launch a Chrome browser to extract the workout information.
Extracted information includes:
- [x] Name
- [x] Muscle group
- [x] Equipment
- [x] Links to the images of the exercises
- [x] Link to the original exercise page
- [ ] Description / Instructions

Steps are:
1. Creates the directory `exercises` in the current path
2. Launches a Chrome browser
3. For each muscle group, create a .txt file and will iterate over every exercise and extract 
   the exercise into the .txt file.

The exercise information is in the following format:
```Incline Hammer Curls
Muscle Targeted: Biceps
Equipment Type: Dumbbell
https://www.bodybuilding.com/exercises/incline-hammer-curls
https://www.bodybuilding.com/exercises/exerciseImages/sequences/882/Male/m/882_2.jpg
https://www.bodybuilding.com/exercises/exerciseImages/sequences/882/Male/m/882_1.jpg

```

Newline intended.
