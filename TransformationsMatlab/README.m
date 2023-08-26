% Doc file for MatlabTransformations

disp( 'What is Julian date corresponding to 2:15 PM today?' );
disp( sprintf( '%10.4f', toJulianDate( '1-February-2020', 10.25 ) ) ...
      );

disp( 'Where is Mars in the sky at 8 PM tonight?' );
tonight8PM = toJulianDate( '2-February-2020', 4 );
[az,el] = findObjectInSky( 4, tonight8PM, -118.5, 34 );
disp( sprintf( 'Azimuth: %f, elevation %f', az, el ) );
if el < 0
  disp( 'Mars is not visible' )
end

disp( 'What physical constants are stored in physicalConstants.m?' );
disp( physicalConstants )
disp( sprintf( 'Gravitational parameter for Earth: %f', ...
               physicalConstant( 'muEarth' ) ) );


