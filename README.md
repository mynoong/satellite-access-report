# Satellite Access Report (a.k.a Satellite Visibility Calculator)

## Overview

The Satellite Access Report is a powerful tool designed to assist ground station operators in optimizing their satellite communication efforts. This program enables users to determine precisely when a specific spacecraft is within line-of-sight (above the horizon) from a designated ground station. Additionally, it provides crucial information such as azimuth, elevation, and range, all of which are essential for establishing successful satellite communication links.

The core functionality relies on ECEF (Earth-Centered, Earth-Fixed) coordinates. It determines the spacecraft's ECEF location at each visibility point, computes the vector from the ground station to the spacecraft, and projects this vector onto local north, east, and up vectors. These vectors are used to calculate azimuth, elevation, and range of where satellite is located.

`accessReport.m` : generates access report of the given TLE data and ground station location

`findECEFLocation` : determines spacecraft ECEF coordinates at the given time and orbital elements

`readTLE.m` : takes two-line TLE data and interpret it into classical orbital elements and the epoch

`TransformationsMatlab` : includes linear algebra and orbital mechanics operations necessary for `accessReport.m` and other programs


## Key Features

- **Precise Visibility Times:** The program calculates and presents precise timestamps indicating when the chosen spacecraft becomes visible from the selected ground station.

- **Directional Data:** It provides azimuth and elevation angles, allowing ground station operators to accurately point their antennas towards the satellite.

- **Range Information:** Users can access the distance (range) between the ground station and the spacecraft, crucial for understanding signal strength and communication capabilities.


## How to Use

1. Download satellite-access-report repositories, including TransformationsMatlab folder.
2. Download TLE data of desired satellite and search location of a desired ground station.
3. Add path for the repository and TransformationsMatlab folder in MATLAB.
4. Write `accessReport( Lo, La, hoursFromUT, tleFilename, txtFilename, times)` in command window and run the code. Parameters of the function accessReport are explained in `test.m`.)

 ## Example Usage
Take reference of `test.m` and the result `accessReport_iss_Seoul.txt`.

`accessReport_iss_Seoul.txt` includes ISS-accessible times and locations from September 18, 2023 midnight to September 21, 2023 midnight in Korean Standard Time (KST), observing from N Seoul Tower. 

## Example Usage Result
Here is the comparison between NASA-predicted data and my custom satellite access report data from `accessReport_iss_Seoul.txt`. 

![accessReportTestDiagram](https://github.com/mynoong/satellite-access-report/assets/113654157/b9026326-300a-436e-b9d8-b78a02287d17)

**Upon examining the comparison, it becomes evident that there is a discrepancy of less than 1 degree in location and less than 10 seconds in time between the two datasets.**

- For your reference, the satellite access report data contains a greater number of data points compared to NASA's predictions. This disparity arises because NASA's data exclusively presents potential naked-eye observation times, taking into consideration factors such as cloud cover and other weather conditions. Conversely, the satellite access report data includes all access times, encompassing both day and night observations.
- You could find public ISS observation data from following websites.  
  https://spotthestation.nasa.gov/sightings/index.c, https://www.astroviewer.net/iss/en/observation.php

   

---

### P.S. Why Use the Satellite Access Report?
Whether for managing a ground station, planning satellite communications, or simply seeking to optimize connectivity with orbiting spacecraft, the Satellite Access Report could be a great resource which provides accurate data and insights.

- **Optimize Communication Windows:** By knowing exactly when a satellite is in view, ground station operators can optimize their communication schedules, minimizing downtime and ensuring reliable data transmission.

- **Antenna Alignment:** The azimuth and elevation data provided by the program assist in accurately aligning antennas, reducing signal losses and maximizing communication efficiency.

- **Strategic Ground Station Placement:** This tool can help ground station operators choose the ideal location for their station, ensuring the ability to communicate with their chosen satellite throughout its orbit.

