# satellite-access-report
## Description
The report lists the times when a given spacecraft is in view (above the horizon) from a given ground station, along with the azimuth, elevation and range (distance between ground station and space- craft). The idea is to find the spacecraft ECEF location at each time; subtract the ground station ECEF location to obtain the vector pointing from ground station to the spacecraft; and find the projections of this vector onto local north, east and up vectors.
