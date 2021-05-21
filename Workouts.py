"""
    Parses the exercises from BodyBuilding.com
"""

from selenium import webdriver
from bs4 import BeautifulSoup
import time
import re
import datetime
import pprint
import os
import shutil
import json

# global variables
equipmentPrefix = 'Equipment Type: '
baseUrl = "https://www.bodybuilding.com/exercises/muscle/"
muscleUrls = ['chest', 'forearms', 'lats',
            'middle-back', 'lower-back', 'neck',
            'quadriceps', 'hamstrings', 'calves',
            'triceps', 'traps', 'shoulders',
            'abdominals', 'glutes', 'biceps',
            'adductors', 'abductors']
# muscleUrls = ['chest'] # For testing

# Represents an exercise
class Excercise():
    def __init__(self, title, equipment, link):
        self.title = title
        self.equipment = equipment
        self.link = link
        self.pictures = []

# Class that controls the browser for parsing exercises
class Br():
    def __init__(self):
        self.browser = webdriver.Chrome('./chromedriver')

    def start(self):
        self.browser.get("https://www.bodybuilding.com/")
        time.sleep(1)

    def load_whole_page(self):
        print("\tLoading all exercises...")

        # close cookie banner first so it doesn't block the load more button
        closeCookieButton = self.browser.find_element_by_class_name('banner-close-button')
        closeCookieButton.click()

        while (True):
            try:
                element = self.browser.find_element_by_class_name("ExLoadMore-btn")
                element.click()
                time.sleep(1)
            except:
                return

    def close_out(self):
        self.browser.close()

    def process_page(self):
        exercises = []
        exerciseElements = self.browser.find_elements_by_class_name('ExResult-cell--nameEtc')

        print(f'\tAmount of exercises to parse: {len(exerciseElements)}...')

        for x in exerciseElements:
            split = x.text.splitlines()
            link = x.find_element_by_css_selector('a').get_attribute('href')

            # Some exercises aren't labeled with equipment
            try:
                parsedEquipment = split[2][split[2].index(equipmentPrefix) + len(equipmentPrefix):]
            except:
                parsedEquipment = ''

            exercise = Excercise(split[0], parsedEquipment, link)

            exercises.append(exercise)

        # go through each exercise and get more detailed information
        for exercise in exercises:
            self.process_pictures(exercise)

        return exercises

    def process_pictures(self, exercise):
        self.browser.get(exercise.link)
        time.sleep(1)
        elements = self.browser.find_elements_by_class_name('ExDetail-imgWrap')
        for x in elements:
            pic_link = x.find_element_by_css_selector('img').get_attribute('src')
            exercise.pictures.append(pic_link)

# Main function for parsing
def run():
    b = Br()
    b.start()

    dir = './exercises'
    if os.path.exists(dir):
        shutil.rmtree(dir)
    os.makedirs(dir)

    for group in muscleUrls:
        exercises = []
        print("********** Currently parsing: " + group + " **********")
        b.browser.get(baseUrl + group)

        # sleep a sec for waiting on load
        time.sleep(1)

        # lazy load all exercises
        b.load_whole_page()

        exercises += b.process_page()

        file_name = group
        complete_name = os.path.join("./exercises", file_name + ".json")
        file = open(complete_name, "w")

        final = {group: [ob.__dict__ for ob in exercises]}
        file.write(json.dumps(final, indent=4))

        file.close()

    b.close_out()

    print("\nDone.")

# Actually run
run()
