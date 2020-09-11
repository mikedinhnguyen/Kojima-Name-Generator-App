# Kojima Name Generator  
---
This was a project I've been wanting to do for a while, under an iOS application. During the end of 2019, I've had the skeleton code made in C++ which you can find [here](https://github.com/mikedinhnguyen/kojima-name-generator). Needless to say, it is messy and I do not like it. Also it only works in a terminal, which is not ideal for UI and I would like other people to participate in it. The purpose of this project is really to get myself familiar with Xcode/Swift and really embrace doing a personal passion project while utilizing my iOS knowledge. My inspiration to do this can be found [here](https://www.polygon.com/videos/2019/11/11/20959269/unraveled-kojima-name-generator-death-stranding). As a big video game nerd, it just seemed like something fun to automate rather than meticulously go through.

### Why did I decide to do this  

It looks relatively easy, even though there's a lot of moving parts, and I plan to add some useful functions eventually to it, such as sharing your name to social media, adding small UI changes to match the Kojima/Solid Snake aesthetic, and maybe even a public board of recent people who made their name that consented to show it worldwide (although I'm really getting ahead of myself).  

This readme file should be updated over the course of time.  

### Updates:  

8/21/2020:
Very barebones prototype to display and take in user input. Still thinking about how to incorporate Kojima conditions and UIPickers into the equation.

8/24/2020:
incorporated UIPickerViews into app, incorporated sound for if there is no user input, started on NameCalculator, which will do most of name changing grunt work, deleted unnecessary JSON files, got full name generator working

8/25/2020:
implemented snake box progress bar, set character limit to 40, ability to reset questionnaire

9/11/2020:
added random button function, app icon, revamp name calc methods

pending features:
- 6 alternate names
- installing typing mods?
- UI/UX interface cleanup
- main menu view controller
    - Start
    - About
    - Donate
- You are Hideo Kojima animation
- if you try to ignore error messages 5 times, you “game over” for not listening and return to the beginning
