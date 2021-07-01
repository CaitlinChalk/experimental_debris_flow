# Mapping car club locations in the UK

Plots and analysis related to car club locations in the UK.
This work is part of a data science project with Leeds Institute for Data Analytics and the Institute for Transport Studies, at the University of Leeds, exploring car clubs as a sustainable alternative to privately owned vehicles.  

1) **Obtaining the car club locations** 
[extracting_car_club_locations.R](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/scripts/extracting_car_club_locations.R) loads and wrangles a json file containing the locations (with lat long coordinates)
of all car club *lots* (i.e. parking bay/pick-up location) in the UK. These data were extracted from an existing interactive map of car club locations on the CoMoUK website (https://como.org.uk/shared-mobility/shared-cars/where/), following the instructions in [this blog post](https://onlinejournalismblog.com/2017/05/10/how-to-find-data-behind-chart-map-using-inspector/). 
CoMoUK, short for Collaborative Mobility UK, are researching and developing shared transport and integrated mobility options in the UK. As well as the lot locations, the scraped car club data also includes the operator of the car club in question, and the
number of vehicles stationed at each lot.
There are five operators in total - Co-Wheels, Enterprise Car Club, Ubeeqo, Zipcar and Zipcar Flex.
The processed data is stored in [car_club_locations.csv](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/data/wrangled/car_club_locations.csv).

2) **Plotting the car club locations**
[mapping_car_club_locations.R](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/scripts/mapping_car_club_locations.R) produces maps showing the distribution of car clubs in the UK.
First, the interactive map on the CoMoUK website is recreated, showing the car club locations and the corresponding operator. This is in html format, and can be downloaded from 
[car_club_locations.html](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/maps/car_club_locations.html). This file is too big to view in github - a static snapshot is provided below: 

<p align="center">
 <img src="https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/maps/car_clubs_html_preview.PNG"  
</p>

3) **Analysing car club distribution at the Local Authority District level**<br>
[car_clubs_lad_level.R](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/scripts/car_clubs_lad_level.R) gets local authority district level variables,
 including the number of car club operators in use per local authority:<br>
![operators_per_lad.png](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/maps/operators_per_lad.png) <br> 
This map shows that car clubs are distributed across all regions of the UK.  
London has the highest concentration of car clubs in the UK, with upto five different operators servicing a single local authority (Wandsworth). Outside of London, there are typically only one or two operators in use (mostly Enterprise and/or Co-wheels).
There are 382 districts in the UK and 217 of them have car club vehicles. There is a considerable section of the UK with no car club coverage.  This includes a swathe of authorities extending from South Wales to the East coast, much of Kent, South West England, Northern Ireland and some authorities in Northern England and Scotland.  Absence of car clubs might be due to both commercial decisions by operators and also the regulatory and planning decisions of local authorities.   <br>
The number of available car club vehicles per local authority is also analysed, giving an idea of which areas are car club "hot spots". <br>
![vehicles_per_lad.png](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/maps/vehicles_per_lad.png) <br> 
Unsurprisingly, the local authorities with the highest number of available vehicles are in London. Wandsworth has the most, with 386 vehicles. Research into car-clubs shows many, but not all, successful schemes operate where there is high population density, a high proportion of younger adults and good public transport.   
There are however areas outside of London with a high number of vehicles, suggesting that car clubs are also popular in these areas.
Edinburgh, with 211 car club vehicles, contains the most car club vehicles outside of London. Edinburgh has one car club operator; Enterprise Car Club. Bristol and Brighton and Hove also 
appear to be popular for car club use, with 130 and 128 vehicles respectively. The table below displays the five local authorities outside of London with 
the most car club vehicles. The local authority level data is stored in [car_clubs_lad.csv](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/data/wrangled/car_clubs_lad.csv). 


| Local Authority       | Number of car club vehicles | Operators  |
|:---------------------:|:-----------------------:|:----------:|
| Edinburgh     | 211 | Enterprise Car Club|
| Bristol      | 130 | Co-Wheels, Enterprise Car Club, Zipcar|
| Brighton and Hove     | 128 | Enterprise Car Club|
| Glasgow 	   | 87  | Co-Wheels, Enterprise Car Club |
| Cambridge    | 63  | Enterprise Car Club, Zipcar | 


## Mapping car club locations in the context of other features of districts
It is useful to see the car club locations in the context of other characteristics of districts.  We might want to try to explain why car clubs locate in some places and not others, for example by using data about the transport characteristics of an area or the ease of reaching places by public transport (what transport planners call accessibility).   


4) **Car clubs and accessibility**<br>
[car_clubs_and_accessibility.R](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/scripts/car_clubs_and_accessibility.R) explores the number of car club vehicles per local authority with respect to
the accessibility of the nearest town. The accessibility data is provided by the Department for Transport (https://www.gov.uk/government/statistical-data-sets/journey-time-statistics-data-tables-jts), and contains the
average time taken per local authority to travel to the nearest town using public transport or by walking. <br>
![travel_time_with_car_clubs.png](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/maps/travel_time_with_car_clubs.png) <br> 
Plotting the travel time against the number of car club vehicles shows that there are generally fewer vehicles available in areas that are less accessibile:
![travel_time_cc_vehicles.png](https://github.com/CaitlinChalk/Mapping_Car_Club_Locations/blob/master/plots/travel_time_cc_vehicles.png) <br> 
This suggests that car clubs are more prevalent in areas with better public transport options.


6) **Further reading**<br>
If you want to know more about car clubs and how they could contribute to decarbonising transport then good start points include:<br>
* Shared mobility – where now, where next? Second report of the Commission on Travel Demand https://www.creds.ac.uk/publications/where-now-where-next/ <br>
* CoMoUK's information on shared cars. https://como.org.uk/shared-mobility/shared-cars/how/ 

