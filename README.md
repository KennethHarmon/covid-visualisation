*Note: This project was originally tracked using SVN and has been subsequently ported over to here*

# Programming project

## Overview:
This project was undertaken as part of my first year CSU-11013 Programming Project module. The project is built using the java processing library and was a great learning experience with many different features implemented and challenges overcome.

## Design outline:
After reviewing the design spec we came up with a concept UI layout to help
guide us in the features we implemented.

![image](https://user-images.githubusercontent.com/31365228/160292875-3b80eabc-79f8-4c7c-bdea-6bd66b926ecf.png)

We wanted to have a main screen providing useful information to the user in a
very visual fashion. As well as the possibility of more detailed screens for
individual areas. One other key feature we wanted to implement with regards
to the front end was for the program to be scalable so it could work on
different screen sizes and resolutions.

## Project Features:
* Custom modular UI system utilising local coordinates that can rescale to any size
* Multiple stat visualisations throughout, including maps, bar charts, pie charts and hisograms.
* Chloropleth map displaying relative case numbers for each state in mainland USA
* Tooltips for displaying detailed info
* Loading bar before main screen
* Separate screen prodiving more detailed information for a particular state

### Main Screen:
![image](https://user-images.githubusercontent.com/31365228/160293083-0097017f-85cf-4452-bf2e-c058ad6f265b.png)

### State Screen:
![image](https://user-images.githubusercontent.com/31365228/160293103-42bf551d-0ee9-4714-b2f9-e83118095bad.png)


## Team Organisation:
We met once a week on a Tuesday to discuss ideas and review progress from
the previous week, as well as establish goals for the next. Then used our
normal Thursday labs to implement some of the features we had discussed.
We used a discord server for group communication, sharing ideas and giving
each other help and feedback and we progressed. The main things each of us
worked on are detailed later in this document.

## Problems Encountered
* Ensuring each module scales properly, was made easier by our module
system, but text in particular was very tough to get scaling properly.
* Speeding up the input of the dataset and the associated filtering
algorithms.
* Deciding on the appropriate manner to store the data. We looked at
using SQL, tried it and decided against it.
