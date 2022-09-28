select * from airport_detail;

select * from cancellation;

select * from flight_detail;

select * from carrier_detail;

# SQL ASSIGNMENT QUESTIONS TO ANSWER

# 1.Find out the airline company which has a greater number of flight movement.
 
SELECT carrierId, 
count(carrierId)
from flight_detail
group by carrierId;

# 2.Get the details of the first five flights that has high airtime.

select carrierid,
  sum(airtime)
  from flight_detail
  group by carrierId
  order by sum(airtime) desc limit 5;
  
  # 4.Find the month in which the flight delays happened to be more.
  
select 
flight_month,
sum(departuredelay)
from flight_detail
group by flight_month
order by sum(departuredelay) desc;

# 6. A customer wants to book a flight under an emergency situation. Which airline would you suggest him to book. Justify your answer.

select
A. carrierid,
carrier_code,
count(flightid) as Flights_count
from flight_detail as F
left join carrier_detail as c
   on f.carrierid = c.Carrier_ID
   where arrivaldelay < 0
   group by A.carrierid, Carrier_code;
   
# 7.Find the dates in each month on which the flight delays are more.
   
   select flight_month,
   flight_date,
   sum(departuredelay)
   from flight_detail
   group by flight_month, flight_date
   order by sum(departuredelay) asc;
   
# 8.Calculate the percentage of flights that are delayed compared to flights that arrived on time.
   select
   carrierId,
   arrivaldelay,
   departuredelay,
   arrivaldelay/sum(arrivaldelay)*100 as arrivaldelaypercentage,
   departuredelay/sum(departuredelay)*100 as departuredelaypercentage
   from flight_detail
   group by carrierId;
   
# 9.Identify the routes that has more delay time.
select routeid,
sum(departuredelay)
group by routeid
order by sum(departuredelay) desc;

# 10.Find out on which day of week the flight delays happen more.
select
  dayweek,
 (avg(arrivaldelay) + avg(departuredelay)) as total_delay
 from flight_detail
 where (arrivaldelay + departuredelay) > 0
 group by dayweek
 order by total_delay desc limit 10;
 
# 11.	Identify at which part of day flights arrive late.

select 
  hour(schedulearrivaltime),
  count(*) as no_of_flights
  from flight_detail
  where arrivaldelay > 0
  group by hour(schedulearrivaltime)
  order by no_of_flights desc limit 1;
  
# 12.Compute the maximum, minimum and average TaxiIn and TaxiOut time.

select
  min(taxiIn),
  max(taxiIn),
  avg(taxiIn),
  min(taxiOut),
  max(taxiOut),
  avg(taxiOut)
from flight_detail;
  
  # 13.Get the details of origin and destination with maximum flight movement.

   select routid
        count(routeId) as flight_count,
       a1.airport_name as origin,
       a2.airport_name as destination
       from flight_detail
       join route_detail
        on route_detail.route_id = flight_detail.routeid
              join airport_detail as a1
	    on a1.locationid = route_detail.origincode
              join airport_detail as a2
		on route_detail.destinationcode = a2.locationid
        groud by flight_detail.routeid
        order by flight_count desc limit 1;
        
# 14.Find out which delay cause occurrence is maximum.
     select 
     sum(case when arrivaldelay > 0 then 1 else 0 end) as arrivaldelay_count,
     sum(case when departuredelay > 0 then 1 else 0 end) as departuredelay_count,
     sum(case when carrierdelay > 0 then 1 else 0 end) as carrierdelay_count,
     sum(case when wheatherdelay > 0 then 1 else 0 end) as wheatherdelay_count,
     sum(case when NASdelay > 0 then 1 else 0 end) as NASdelay_count,
     sum(case when securitydelay > 0 then 1 else 0 end) as securitydelay_count,
     sum(case  when Late_aircraft_delay > 0 then 1 else 0 end) as Late_aircraft_delay_count
     from flight_detail; 
     
# 15.Get details of flight whose speed is between 400 to 600 miles/hr for each airline company.

select*
from flight_detail
where speed > 400 and speed < 600
order by carrierId desc;

# 16.Identify the best time in a day to book a flight for a customer to reduce the delay.
   select hour(scheduleddeparturetime) as slot_time,
         avg(departuredelay),
         avg(arrivaldelay),
         (avg(departuredelay) + avg(arrivaldelay) ) as total_delay
         from flight_detail
         group by hour(scheduleddeparturetime)
         order by total_delay limit 1;
  # 17.Get the route details with airline company code ‘AQ’     
  
  select distinct(routeId),
           a1.airport_name as origin,
           a2.airport_name as destination
		   from flight_detail
           left join carrier_detail
             on carrier_detail.Carrier_ID =  flight_detail.carrierId
		   join route_detail 
			 on route_detail.route_ID = flight_detail.routeId
		   join airport_detail as a1
             on a1.locationId = route_detail.origincode
		   join airport_detail as a2
             on route_detail.destinationcode = a2.locationId
	       where carrierId = 17;
           
# 18.Identify on which dates in a year flight movement is large.

  select flight_date,
      count(flight_date) as no_of_flights
      from flight_detail
      group by flight_date
      order by  no_of_flights limit 10;

# 19.Find out which delay cause is occurring more for each airline company.

     select    carrierId,
                   sum(case  when arrivaldelay > 0 then 1 else 0 end ) as arrivaldelay_count  ,                     
                   sum(case  when departuredelay > 0 then 1 else 0 end )as departuredelay_count,  
                   sum(case  when carrierdelay > 0 then 1 else 0 end )as carrierdelayy_count,
                   sum(case  when weatherdelay > 0 then 1 else 0 end )as weatherdelay_count,
                   sum(case  when NASdelay > 0 then 1 else 0 end )as NASdelay_count,
                   sum(case  when securitydelay > 0 then 1 else 0 end )as securitydelay_count,
                   sum(case  when Late_aircraft_delay > 0 then 1 else 0 end )as Late_aircraft_delay_count
                   from flight_detail
                   group by carrierId;
                   
# 20.Write a query that represent your unique observation in the database.

     select 
      count(flightid) 
from flight_detail
where diverted = 1;
           
         