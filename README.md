# Satellite Access Report
## (a.k.a Satellite Visibility Calculator)

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
4. Write `accessReport( Lo, La, hoursFromUT, tleFilename, times)` in command window and run the code.
   Lo: longitude of desired ground station location (ex. for ground station at N Seoul Tower, Lo = +126.9882)
   La: latitude of desired ground station location (ex. for ground station at N Seoul Tower, La = +37.5512)
   hoursFromUT: time difference between ground station location and UTC (ex. for ground stations in South Korea, hoursFromUT = +9)
   tleFilename: TLE file name of desired satellite (ex. tleFilename = 'iss.tle')
   times: list of julian dates for observation in row vector

 ## Example Usage
   

---
## P.S.

## Why Use the Satellite Access Report?
Whether for managing a ground station, planning satellite communications, or simply seeking to optimize connectivity with orbiting spacecraft, the Satellite Access Report could be a great resource which provides accurate data and insights.

- **Optimize Communication Windows:** By knowing exactly when a satellite is in view, ground station operators can optimize their communication schedules, minimizing downtime and ensuring reliable data transmission.

- **Antenna Alignment:** The azimuth and elevation data provided by the program assist in accurately aligning antennas, reducing signal losses and maximizing communication efficiency.

- **Strategic Ground Station Placement:** This tool can help ground station operators choose the ideal location for their station, ensuring the ability to communicate with their chosen satellite throughout its orbit.




## Model Comparison

| Linear (SD = 6.49 cm)               | Linear Gauss (SD = 3.65 cm, but overfitting issue)  | Linear Gauss w/ LOOCV (SD = 4.20 cm)                                     |
| ----------------------------------- | ----------------------------------- | ------------------------------------------- |
| ![linear](https://github.com/mynoong/machine-learning-basics/assets/113654157/bf6fd75a-e216-44d4-804d-34c8ffea8519) | ![gauss](https://github.com/mynoong/machine-learning-basics/assets/113654157/503d2b65-169a-40d6-a5ee-094a8ff9073d) | ![gaussLOOCV](https://github.com/mynoong/machine-learning-basics/assets/113654157/34f09990-c56c-4ba5-aff7-1ef2e6dbbee1) |

| New Customized Model (SD = 3.55 cm) | *2-D input Linear  (SD = 3.79 cm) |                           
| ----------------------------------- | ----------------------------------- | 
| ![linear](https://github.com/mynoong/machine-learning-basics/assets/113654157/cc1bd306-de02-4c73-800d-96ad2d1b3458) | ![linear2dinput](https://github.com/mynoong/machine-learning-basics/assets/113654157/7a0b9df0-ac6c-43e3-b9b4-7ad08e0e3ade) |
